# -*- encoding : utf-8 -*-
module ProjectGroupPlugin
  module ProjectsHelperPatch

    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        include ChiliprojectMembersView::ProjectsHelperPatch
        alias_method_chain :project_settings_tabs, :project_groups
        alias_method_chain :load_principals, :project_groups
      end
    end

    module ClassMethods
    end

    module InstanceMethods

      def project_settings_tabs_with_project_groups
        tabs = project_settings_tabs_without_project_groups
        if User.current.allowed_to?(:manage_project_groups, @project)
          tabs.push({:name => 'project_groups',
                     :action => :manage_project_groups,
                     :partial => 'projects/settings/project_groups',
                     :label => :label_group_plural})
        end
        tabs
      end

      def load_principals_with_project_groups(project)
        principals = load_principals_without_project_groups(project)
        project.project_groups - project.principals + principals
      end
    end

  end
end
