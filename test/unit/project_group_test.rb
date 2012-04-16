# -*- encoding : utf-8 -*-
require File.expand_path('../../test_helper', __FILE__)

class ProjectGroupTest < ActiveSupport::TestCase

  should_have_many :projects, :through => :project_group_scopes

  should_belong_to :parent_project
  should_validate_presence_of :parent_project
  should_not_allow_mass_assignment_of :parent_project

  should "create new project group" do
    g = ProjectGroup.create(:lastname => "Project group")
    g.parent_project = Project.generate!
    assert g.save
  end

end
