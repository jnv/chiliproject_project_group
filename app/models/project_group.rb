# -*- encoding : utf-8 -*-
class ProjectGroup < Group
  unloadable

  has_many :project_group_scopes, :dependent => :destroy
  has_many :projects, :through => :project_group_scopes, :uniq => true
  belongs_to :parent_project, :foreign_key => 'project_group_project_id', :class_name => 'Project'

  attr_protected :parent_project

  validates_presence_of :parent_project

  after_create :add_to_descendants

  def is_child_of?(project)
    project_id = project.is_a?(Project) ? project.id : project.to_i
    project_id == parent_project.id
  end

  private

  # Once a group is created, it should be available to all
  # subprojects of the parent project
  def add_to_descendants
    parent_project.descendants.each do |project|
      project.project_groups << self
    end
  end

end
