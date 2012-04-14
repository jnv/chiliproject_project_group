require File.expand_path('../../../../test_helper', __FILE__)

class ProjectGroupPlugin::ProjectPatchTest < Test::Unit::TestCase

  context "Project" do
    subject {Project.new}
    should_have_many :project_groups, :through => :project_group_scopes
  end

end