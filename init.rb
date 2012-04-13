require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare :project_role_plugin do
  require_dependency 'project'
  Project.send(:include, ProjectGroupProjectPatch) unless Project.included_modules.include? ProjectGroupProjectPatch
end

Redmine::Plugin.register :chiliproject_project_group do
  name 'Project Groups'
  author 'Jan Vlnas'
  description 'Provides per-project user groups'
  version '0.0.1'
  url 'https://github.com/jnv/chiliproject_project_group'
  author_url 'https://github.com/jnv'
end
