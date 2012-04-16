# -*- encoding : utf-8 -*-
require File.expand_path('../../../../test_helper', __FILE__)
class ProjectGroupPlugin::ProjectsHelperPatchTest < ActiveSupport::TestCase

  include ProjectGroupPlugin::ProjectsHelperPatch

  def setup
    @project_group = ProjectGroup.new({:lastname => "Project Group 1"})
    @nonproject_group = ProjectGroup.new({:lastname => "Project Group 2"})
    @project_group_member = User.find(5)
    @project_group.users << @project_group_member
    @project = Project.find(1)
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
