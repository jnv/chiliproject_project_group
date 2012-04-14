module ProjectGroup
  module ProjectsHelperPatch

    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        alias_method_chain :project_settings_tabs, :project_groups
      end
    end

    module ClassMethods
    end

    module InstanceMethods

      def project_settings_tabs_with_project_groups
        tabs = project_settings_tabs_without_project_groups
        #if User.current.allowed_to?(:manage_project_groups, @project)
        tabs.push({:name => 'project_groups',
                   :action => :manage_project_groups,
                   :partial => 'projects/settings/project_groups',
                   :label => :label_group_plural})
        #end
        tabs
      end

    end

  end
end