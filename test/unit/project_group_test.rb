# -*- encoding : utf-8 -*-
require File.expand_path('../../test_helper', __FILE__)

class ProjectGroupTest < ActiveSupport::TestCase

  fixtures :projects

  should_have_many :projects, :through => :project_group_scopes

  context "parent_project" do
    should_belong_to :parent_project
    should_validate_presence_of :parent_project
    should_not_allow_mass_assignment_of :parent_project
  end

  should "create new project group" do
    g = ProjectGroup.create(:lastname => "Project group")
    g.parent_project = Project.generate!
    assert g.save
  end

  context "#add_to_descendants" do
    setup do
      @project = Project.generate!
      @subproject = Project.generate! do |subproject|
        subproject.set_parent!(@project)
      end
    end

    should "add new group to project's descendants" do
      group = ProjectGroup.generate_for_project!(@project)
      assert_include @subproject.project_groups, group
    end

  end

end
