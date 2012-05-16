# -*- encoding : utf-8 -*-
module ProjectGroupPlugin
  module ProjectsControllerPatch

    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        before_filter :load_project_groups, :only => :settings
      end
    end

    module ClassMethods
    end

    module InstanceMethods

      def load_project_groups
        @project_groups = @project.project_groups
      end
    end

  end
end
