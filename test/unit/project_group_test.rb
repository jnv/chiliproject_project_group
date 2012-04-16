# -*- encoding : utf-8 -*-
require File.expand_path('../../test_helper', __FILE__)

class ProjectGroupTest < ActiveSupport::TestCase

  should_have_many :projects, :through => :project_group_scopes

  should "create new project group" do
    g = ProjectGroup.create(:lastname => "Project group")
    assert g.save
  end

end
