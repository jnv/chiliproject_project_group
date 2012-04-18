# -*- encoding : utf-8 -*-
module ProjectGroupPlugin
  module MembersControllerPatch

    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable

        alias_method_chain :autocomplete_for_member, :project_groups
      end
    end

    module ClassMethods
    end

    module InstanceMethods

      def autocomplete_for_member_with_project_groups
        #autocomplete_for_member_without_project_groups # won't call

        @principals = @project.project_groups.like(params[:q]) + Principal.active.like(params[:q]).find(:all, :limit => 100) - @project.principals
        render :layout => false
      end
    end

  end
end
