# -*- encoding : utf-8 -*-
require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare :project_group_plugin do
  require_dependency 'project'
  unless Project.included_modules.include? ProjectGroupPlugin::ProjectPatch
    Project.send(:include, ProjectGroupPlugin::ProjectPatch)
  end

  require_dependency 'projects_helper'
  unless ProjectsHelper.included_modules.include? ProjectGroupPlugin::ProjectsHelperPatch
    ProjectsHelper.send(:include, ProjectGroupPlugin::ProjectsHelperPatch)
  end

  require_dependency 'group'
  unless Group.included_modules.include? ProjectGroupPlugin::GroupPatch
    Group.send(:include, ProjectGroupPlugin::GroupPatch)
  end

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
