require_dependency 'project_group'
class ProjectGroup < Group
  generator_for :lastname, :start => 'Project Group 00'

  generator_for :projects, :method => :generate_projects

  def self.generate_projects
    [Project.generate!]
  end

end