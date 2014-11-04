module RedmineTweetbook
  module Hooks
    class TweetbookHooks < Redmine::Hook::ViewListener
      render_on :view_layouts_base_html_head, :partial => 'shared/tweetbook'
    end

    class ControllerIssuesEditAfterSaveHook < Redmine::Hook::ViewListener
      def controller_issues_edit_after_save(context={})
        context[:issue].context = context
        issue = context[:issue]
        project = issue.project
        if project.module_enabled?(:web_hook) && TweetBookSetting[:web_hook_url, project.id].present?
          begin
            `curl -X POST -H \"Content-Type: application/json\" -d '{\"title\": \"##{issue.id} #{issue.tracker.to_s} #{issue.project.to_s} #{issue.subject}\", \"message\": \"#{issue.current_journal.notes}\", \"picture\": \"images/logo.png\"}' #{TweetBookSetting[:web_hook_url, project.id]}`
            # TODO: put this in logger
            # puts "RedmineTweetBook - WebHook :: #{out}"
          rescue => e
            puts "RedmineTweetBook - WebHook :: #{e}"
          end
        end
      end
    end

    class ControllerIssuesNewAfterSaveHook < Redmine::Hook::ViewListener
      def controller_issues_new_after_save(context={})
        context[:issue].context = context
        issue = context[:issue]
        project = issue.project
        if project.module_enabled?(:web_hook) && TweetBookSetting[:web_hook_url, project.id].present?
          begin
            `curl -X POST -H \"Content-Type: application/json\" -d '{\"title\": \"##{issue.id} #{issue.tracker.to_s} #{issue.project.to_s} #{issue.subject}\", \"message\": \"#{issue.description}\", \"picture\": \"images/logo.png\"}'  #{TweetBookSetting[:web_hook_url, project.id]}`
            # TODO: put this in logger
            # puts "RedmineTweetBook - WebHook :: #{out}"
          rescue => e
            puts "RedmineTweetBook - WebHook :: #{e}"
          end
        end
      end # def
    end
  end # Hooks
end