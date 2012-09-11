# -*- encoding : utf-8 -*-
module ProjectGroupPlugin
  module MembersViewHelperPatch

    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        #extend InstanceMethods
        alias_method_chain :load_principals, :project_groups
      end
    end

    module InstanceMethods

      def load_principals_with_project_groups(project)
        principals = load_principals_without_project_groups(project)
        project.project_groups - project.principals + principals
      end
    end

  end
end
