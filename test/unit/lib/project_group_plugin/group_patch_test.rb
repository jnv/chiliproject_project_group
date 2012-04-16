# -*- encoding : utf-8 -*-
require File.expand_path('../../../../test_helper', __FILE__)

# Use and run existing test to be on safe side'
require File.expand_path('test/unit/group_test', RAILS_ROOT)

class GroupTest < ActiveSupport::TestCase

  context "Group" do
    subject { Group.new }

    should_validate_uniqueness_of :lastname, :scoped_to => "project_group_project_id"

  end

end
