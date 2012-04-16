# -*- encoding : utf-8 -*-
class ProjectGroup < Group
  unloadable

  has_many :project_group_scopes
  has_many :projects, :through => :project_group_scopes

  def scope_with_project(project)
    project_id = project.is_a?(Project) ? project.id : project.to_i
    ProjectGroupScope.first(:conditions => {:project_id => project_id, :project_group_id => id})
  end
end
