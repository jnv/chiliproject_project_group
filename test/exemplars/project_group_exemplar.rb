# -*- encoding : utf-8 -*-
require_dependency 'project_group'
class ProjectGroup < Group
  generator_for :lastname, :start => 'Project Group 00'

  generator_for :projects, :method => :generate_projects

  def self.generate_projects
    [Project.generate!]
  end

end

def ProjectGroup.generate_for_project!(project, is_manageable = true, attributes={})
  group = ProjectGroup.spawn(attributes) do |group|
    group.parent_project = project
    group.projects = []
  end
  group.save!

  scope = group.project_group_scopes.create(:project => project)
  scope.manageable = is_manageable
  scope.save!

  group
end
