# -*- encoding : utf-8 -*-
require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare :project_role_plugin do
  require_dependency 'project'
  Project.send(:include, ProjectGroupPlugin::ProjectPatch) unless Project.included_modules.include? ProjectGroupPlugin::ProjectPatch

  require_dependency 'projects_helper'
  ProjectsHelper.send(:include, ProjectGroupPlugin::ProjectsHelperPatch) unless ProjectsHelper.included_modules.include? ProjectGroupPlugin::ProjectsHelperPatch

  require_dependency 'projects_controller'
  ProjectsController.send(:include, ProjectGroupPlugin::ProjectsControllerPatch) unless ProjectsHelper.included_modules.include? ProjectGroupPlugin::ProjectsControllerPatch

  require_dependency 'group'
  Group.send(:include, ProjectGroupPlugin::GroupPatch) unless Group.included_modules.include? ProjectGroupPlugin::GroupPatch

  require_dependency 'members_controller'
  unless MembersController.included_modules.include? ProjectGroupPlugin::MembersControllerPatch
    MembersController.send(:include, ProjectGroupPlugin::MembersControllerPatch)
  end
end

Redmine::Plugin.register :chiliproject_project_group do
  name 'Project Groups'
  author 'Jan Vlnas'
  description 'Provides per-project user groups'
  version '0.0.1'
  url 'https://github.com/jnv/chiliproject_project_group'
  author_url 'https://github.com/jnv'

  permission :manage_project_groups, {:project_groups => [:show, :new, :edit, :create, :update, :destroy, :add_users, :remove_user]}, :require => :member
end
