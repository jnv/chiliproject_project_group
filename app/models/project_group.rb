# -*- encoding : utf-8 -*-
class ProjectGroup < Group
  unloadable

  has_many :project_group_scopes, :dependent => :destroy
  has_many :projects, :through => :project_group_scopes
  belongs_to :parent_project, :foreign_key => "project_group_project_id", :class_name => 'Project'

  attr_protected :parent_project

  validates_presence_of :parent_project

  def scope_with_project(project)
    project_id = project.is_a?(Project) ? project.id : project.to_i
    ProjectGroupScope.first(:conditions => {:project_id => project_id, :project_group_id => id})
  end
end
