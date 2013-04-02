module RedmineTweetbook
  module Patches
    module AccountControllerPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods        
        def tweetbook_authenticate
          auth_hash = request.env['omniauth.auth']
          tweet_book = TweetBook.find_by_provider_and_uid(auth_hash['provider'], auth_hash['uid']) || TweetBook.create_with_auth_hash(auth_hash)

          user = User.find_or_initialize_by_mail(tweet_book.email)
	        if user.new_record?
      	    # Self-registration off
            redirect_to(home_url) && return unless Setting.self_registration?

            # Create on the fly
            user.login = tweet_book.nickname + '_' + tweet_book.uid unless tweet_book.nickname.nil?
            user.mail = tweet_book.email unless tweet_book.email.nil?
            user.firstname, user.lastname = tweet_book.name.split(' ') unless tweet_book.name.nil?
            user.random_password
            user.register

            case Setting.self_registration
            when '1'
              register_by_email_activation(user) do
                onthefly_creation_failed(user)
              end
            when '3'
              register_automatically(user) do
                onthefly_creation_failed(user)
              end
            else
              register_manually_by_administrator(user) do
                onthefly_creation_failed(user)
              end
            end
            tweet_book.update_attribute :user_id, user.id
          else
            # Existing record
            if user.active?
              successful_authentication(user)
            else
              account_pending
            end
          end	
        rescue AuthSourceException => e
          logger.error "An error occured when authenticating #{e.message}"
          render_error :message => e.message
        end

      end
    end # end Account Controller patch
  end
end

unless AccountController.included_modules.include?(RedmineTweetbook::Patches::AccountControllerPatch)
  AccountController.send(:include, RedmineTweetbook::Patches::AccountControllerPatch)
end