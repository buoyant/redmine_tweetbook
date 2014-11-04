module RedmineTweetbook
  module Hooks
    class TweetbookHooks < Redmine::Hook::ViewListener
      render_on :view_layouts_base_html_head, :partial => 'shared/tweetbook'
    end

    class ControllerIssuesEditAfterSaveHook < Redmine::Hook::ViewListener
      def controller_issues_edit_after_save(context={})
        context[:issue].context = context
        issue = context[:issue]
        `curl -X POST -H \"Content-Type: application/json\" -d '{\"title\": \"#{issue.subject}\", \"message\": \"#{issue.current_journal.notes}\", \"picture\": \"favicon.ico\"}' https://hall.com/api/1/services/generic/1d961fe36a330d3a2b1b377c5b92f617`
      end
    end

    class ControllerIssuesNewAfterSaveHook < Redmine::Hook::ViewListener
      def controller_issues_new_after_save(context={})
        context[:issue].context = context
        issue = context[:issue]
        `curl -X POST -H \"Content-Type: application/json\" -d '{\"title\": \"#{issue.subject}\", \"message\": \"#{issue.description}\", \"picture\": \"favicon.ico\"}' https://hall.com/api/1/services/generic/1d961fe36a330d3a2b1b377c5b92f617`
      end
    end
  end
end