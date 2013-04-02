class TweetBook < ActiveRecord::Base
  unloadable
  belongs_to :user
  # belongs_to :project

  def self.create_with_auth_hash(auth_hash)
  	# mostly for twitter
  	auth_hash_email = auth_hash['info']['email'] ? auth_hash['info']['email'] : "#{auth_hash['uid']}@#{auth_hash['provider']}.com"
	create! do |tweet_book|
	  tweet_book.provider  = auth_hash['provider']
	  tweet_book.uid       = auth_hash['uid']
	  tweet_book.name      = auth_hash['info']['name']
	  tweet_book.nickname  = auth_hash['info']['nickname']	  
	  tweet_book.email     = auth_hash_email
	  tweet_book.image     = auth_hash['info']['image']
	end
  end

  def self.current_user(id)
    @current_user ||= find_by_user_id(id) 
  end
end