# -*- encoding : utf-8 -*-
require File.expand_path('../../../../test_helper', __FILE__)

require_dependency 'project'
class ProjectGroupPlugin::ProjectPatchTest < ActiveSupport::TestCase

  #fixtures :projects

  context "Project" do
    subject { Project.new }

    should_have_many :project_groups, :through => :project_group_scopes

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
  end

end
