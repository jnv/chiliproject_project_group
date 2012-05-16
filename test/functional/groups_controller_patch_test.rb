# -*- encoding : utf-8 -*-
require File.expand_path('../../test_helper', __FILE__)

# Reuse the default test
require File.expand_path('test/functional/groups_controller_test', RAILS_ROOT)

require_dependency "groups_controller"
class GroupsControllerTest < ActionController::TestCase

  fixtures :all

  context "ProjectGroupsPlugin" do
    setup do
      @project_group = ProjectGroup.generate_for_project!(Project.find(1), {:lastname => "project_group"})
      @request.session[:user_id] = 1 # admin
    end

    context "GET index" do
      setup do
        get :index
      end

      should "not include not fail due to class caching" do
        assert_response :success
      end

      should "not include any ProjectGroup" do
        assert assigns(:groups).none? { |g| g.kind_of? ProjectGroup }
      end

      #should_respond_with :success
      #should_render_template :settings
    end


  end


end
