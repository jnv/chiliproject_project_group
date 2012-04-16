# -*- encoding : utf-8 -*-
module ProjectGroupPlugin
  module ProjectsControllerPatch

    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable

        before_filter :load_members, :only => :settings

        #XXX overrides default method
        #named_scope :active, :conditions => "#{Principal.table_name}.type='ProjectGroup' OR #{Principal.table_name}.type='Group' OR (#{Principal.table_name}.type='User' AND #{Principal.table_name}.status = 1)"
      end
    end

    module ClassMethods
    end

    module InstanceMethods


      # Prepares variables for settings/_members partial
      # @note This should be really done in controller by default
      #   instead of calling models directly from view.
      def load_members
        @roles = Role.find_all_givable
        @members = @project.member_principals.find(:all, :include => [:roles, :principal]).sort
        @principals = @project.project_groups + Principal.active.find(:all, :limit => 100, :order => 'type, login, lastname ASC') - @project.principals
      end

    end

  end
end
