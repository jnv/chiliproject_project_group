# -*- encoding : utf-8 -*-
require File.expand_path('../../test_helper', __FILE__)

# Reuse the default test
require File.expand_path('test/functional/members_controller_test', RAILS_ROOT)

class MembersControllerTest < ActionController::TestCase

  fixtures :projects, :members, :member_roles, :roles, :users

  context "ProjectGroupsPlugin" do

    context "GET autocomplete_for_member" do
      setup do
        @group = ProjectGroup.generate_for_project!(Project.find(1), {:lastname => "project_group"})
        get :autocomplete_for_member, :id => 1, :q => 'proj'
      end

      should_respond_with :success
      should_render_template :autocomplete_for_member

      should "include project group in response" do
        assert_tag :label, :content => /project_group/,
                   :child => {:tag => 'input', :attributes => {:name => 'member[user_ids][]', :value => @group.id}}
      end
    end

  end
end
