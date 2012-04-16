# -*- encoding : utf-8 -*-
require File.expand_path('../../test_helper', __FILE__)

# Reuse the default test
require File.expand_path('test/functional/projects_controller_test', RAILS_ROOT)

class ProjectsControllerTest < ActionController::TestCase

  #subject { ProjectsController }

  context "ProjectGroupsPlugin" do
    setup do
      @request.session[:user_id] = 2 # manager
    end

    context "GET settings" do
      setup do
        get :settings, :id => 1
      end

      should_respond_with :success
      should_render_template :settings
    end

    context "#load_members" do
      setup do
        @project_group = ProjectGroup.new({:lastname => "Project Group 1"})
        @nonproject_group = ProjectGroup.new({:lastname => "Project Group 2"})
        @project_group_member = User.find(5)
        @project_group.users << @project_group_member
        @project = Project.find(1)
        @project.project_groups << @project_group

        get :settings, :id => 1
      end

      should_assign_to(:roles)
      should_assign_to(:members)
      should_assign_to(:principals)

      should "assign project groups to principals" do
        assert_include assigns(:principals), @project_group
      end

      should "not assign non-project group to principals" do
        assert_not_include assigns(:principals), @nonproject_group
      end
    end

  end


end
