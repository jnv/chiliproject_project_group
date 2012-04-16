# -*- encoding : utf-8 -*-
require File.expand_path('../../test_helper', __FILE__)

class ProjectGroupScopeTest < ActiveSupport::TestCase

  should_belong_to :project
  should_belong_to :project_group

  should_not_allow_mass_assignment_of :manageable

end
