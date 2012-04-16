# -*- encoding : utf-8 -*-
module ProjectGroupPlugin
  module ProjectPatch

    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        has_many :project_group_scopes
        has_many :project_groups, :through => :project_group_scopes

        #XXX overrides default associtation
        has_many :member_principals, :class_name => 'Member',
                 :include => :principal,
                 :conditions => "#{Principal.table_name}.type='ProjectGroup' OR #{Principal.table_name}.type='Group' OR (#{Principal.table_name}.type='User' AND #{Principal.table_name}.status=#{User::STATUS_ACTIVE})"

        alias_method_chain :set_parent!, :project_groups
      end
    end

    module ClassMethods
    end

    module InstanceMethods

      def set_parent_with_project_groups!(p)
        set_parent_without_project_groups!(p)
      end

    end

  end
end
