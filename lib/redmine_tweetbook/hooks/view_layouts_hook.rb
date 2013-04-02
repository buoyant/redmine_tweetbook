module RedmineTweetbook
  module Hooks
    class ViewsLayoutsHook < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(context={})      	
        return stylesheet_link_tag(:tweetbook, :plugin => 'redmine_tweetbook')
      end
    end
  end
end