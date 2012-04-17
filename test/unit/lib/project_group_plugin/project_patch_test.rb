# -*- encoding : utf-8 -*-
require File.expand_path('../../../../test_helper', __FILE__)

require_dependency 'project'
class ProjectGroupPlugin::ProjectPatchTest < ActiveSupport::TestCase

  #fixtures :all

  context "Project" do
    subject { Project.new }

    should_have_many :project_groups, :through => :project_group_scopes
    should_have_many :child_groups, :dependent => :destroy

    context "#member_principals" do
      setup do
        @project = Project.generate!(:trackers => [])
        @group = ProjectGroup.generate!(:projects => [@project], :parent_project => @project)
        @member = Member.generate(:principal => @group, :project => @project)
      end

      should "include member which is ProjectGroup" do
        assert_include @project.member_principals, @member
      end

      should "include ProjectGroups through principals" do
        assert_include @project.principals, @group
      end
    end

    context "#rebuild_group_hierarchy!" do
      # 1 - 3
      #   - 4
      #   - 5 - 6
      # 2 - nil
      setup do
        @root = Project.find(1)
        @root2 = Project.find(2)
        @subproject6 = Project.find(6)
        @subproject3 = Project.find(3)
        @subgroup6 = ProjectGroup.generate_for_project!(@subproject6, :lastname => "6")
        @subgroup3 = ProjectGroup.generate_for_project!(@subproject3, :lastname => "3")

        @root_group = ProjectGroup.generate_for_project!(@root, :lastname => "root")
      end

      context "subproject" do
        should "have root groups available" do
          assert_include @subproject6.project_group_ids, @root_group.id
        end
      end

      should "remove all inherited groups" do
        @subproject6.set_parent!(@root2)
        assert_not_include @subproject6.project_group_ids, @root_group.id
      end

      should "make parent's groups available" do
        @root2.set_parent!(@subproject6)
        assert_include @root2.project_group_ids, @root_group.id
        assert_include @root2.project_group_ids, @subgroup6.id
      end

      # 1 - 3'- 5 - 6'
      #   - 4
      should "make groups available for descendants" do
        assert_not_include @subproject6.project_group_ids, @subgroup3.id
        project5 = Project.find(5)
        project5.set_parent!(@subproject3)
        assert_include @subproject6.project_group_ids, @subgroup3.id
      end
    end

    context "#add_parents_groups!" do
      setup do
        @root = Project.find(1)
        @root_group = ProjectGroup.generate_for_project!(@root)
      end

      # Project#set_parent! should be always called on new project so we don't need an after_create callback
      should "populate parent's groups in new projects" do
        project = Project.generate! do |proj|
          proj.set_parent!(@root)
        end

        assert_include project.project_groups, @root_group
      end
    end

  end

end
