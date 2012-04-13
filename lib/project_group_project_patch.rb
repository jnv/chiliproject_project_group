module ProjectGroupProjectPatch

  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      has_many :project_group_scopes
      has_many :project_groups, :through => :project_group_scopes
    end
  end

  module ClassMethods
  end

  module InstanceMethods
  end

end