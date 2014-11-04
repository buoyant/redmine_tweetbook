require_dependency 'queries_helper'

module RedmineTweetbook
  module Patches
    module ProjectsHelperPatch
      def self.included(base)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable

          alias_method_chain :project_settings_tabs, :webhook
        end
      end


      module InstanceMethods

        def project_settings_tabs_with_webhook
          tabs = project_settings_tabs_without_webhook
          tabs.push({ :name => 'web_hook',
                      :action => :edit_web_hook_settings,
                      :partial => 'projects/settings/web_hook_settings',
                      :label => :label_web_hook })

          tabs.select {|tab| User.current.allowed_to?(tab[:action], @project)}
        end

      end

    end
  end
end

unless ProjectsHelper.included_modules.include?(RedmineTweetbook::Patches::ProjectsHelperPatch)
  ProjectsHelper.send(:include, RedmineTweetbook::Patches::ProjectsHelperPatch)
end
