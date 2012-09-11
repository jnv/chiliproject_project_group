# -*- encoding : utf-8 -*-
require File.expand_path('../../../../test_helper', __FILE__)
class ProjectGroupPlugin::MembersViewHelperPatchTest < ActiveSupport::TestCase

  fixtures :users, :projects, :members, :roles, :member_roles

  include MembersViewHelper

  def setup
    @project = Project.find(1)
    @project_group = ProjectGroup.new(:lastname => "Project Group 1")
    @project_group.parent_project = @project
    @nonproject_group = ProjectGroup.new(:lastname => "Project Group 2")
    @nonproject_group.parent_project = Project.generate!
    @project_group_member = User.find(5)
    @project_group.users << @project_group_member
    @project.project_groups << @project_group
  end

  context "#load_principals" do

    subject { load_principals(@project) }

    should "include project groups" do
      assert_include subject, @project_group
    end

    should "not include non-project groups" do
      assert_not_include subject, @nonproject_group
    end

  end


end
