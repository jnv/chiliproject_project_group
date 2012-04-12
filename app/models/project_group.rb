class ProjectGroup < Group
  unloadable

  has_many :project_group_scopes
  has_many :projects, :through => :project_group_scopes
end
