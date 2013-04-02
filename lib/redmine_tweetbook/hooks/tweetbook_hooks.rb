module RedmineTweetbook
  module Hooks
    class TweetbookHooks < Redmine::Hook::ViewListener      
      render_on :view_layouts_base_html_head, :partial => 'shared/tweetbook'      
    end
  end
end