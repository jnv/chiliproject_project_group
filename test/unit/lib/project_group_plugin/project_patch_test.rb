require File.expand_path('../../../../test_helper', __FILE__)

require_dependency 'project'
class ProjectGroupPlugin::ProjectPatchTest < ActiveSupport::TestCase

  #fixtures :projects

  context "Project" do
    subject { Project.new }

    should_have_many :project_groups, :through => :project_group_scopes

    context "#member_principals" do
      setup do
        @group = ProjectGroup.generate!
        @project = Project.generate!(:trackers => [])
        Member.generate(:principal => @group, :project => @project)
      end

      should "include ProjectGroups" do
        assert_include @project.member_principals, @group
      end

    end
  end

end