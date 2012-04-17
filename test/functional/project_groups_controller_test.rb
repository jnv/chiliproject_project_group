# -*- encoding : utf-8 -*-
require File.expand_path('../../test_helper', __FILE__)

class ProjectGroupsControllerTest < ActionController::TestCase

  fixtures :projects, :versions, :users, :roles, :members, :member_roles
  #fixtures :all

  def setup
    @controller = ProjectGroupsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    Setting.default_language = 'en'

    Role.find(1).add_permission! :manage_project_groups
    #User.current = nil
    @request.session[:user_id] = 2 # manager, member of Project 1

    @project = Project.find(1)
    @group = ProjectGroup.generate!(:projects => [@project])

    @member = User.generate!
    @group.users << @member

    @project_group_scope = @group.scope_with_project(@project)
    @project_group_scope.manageable = true
    @project_group_scope.save!

    @nonmember = User.generate!
  end

  context "GET show" do
    setup do
      get :show, :project_id => @project, :id => @group
    end

    should_assign_to(:project_group) { @group }
  end

  context "GET new" do
    setup do
      get :new, :project_id => @project
    end

    should_assign_to :project_group, :class => ProjectGroup

    should "assign a project to the assigned group" do
      assert_include assigns(:project_group).projects, @project
    end
  end

  context "GET edit" do
    setup do
      get :edit, :project_id => @project, :id => @group
    end

    should_assign_to(:project_group) { @group }

    should "assign to @users_not_in_group" do
      assert_include(assigns(:users_not_in_group), @nonmember)
      assert_not_include(assigns(:users_not_in_group), @member)
    end
  end

  context "PUT update" do
    setup do
      put :update, :project_id => @project, :id => @group, :project_group => {:lastname => 'Changed group'}
    end

    #should_redirect_to edit_project_group_url(@project, @group)

    should "change group's name" do
      assert_equal @group.reload.lastname, 'Changed group'
    end
  end

  context "POST add_users" do
    should "add users" do
      assert_difference "ProjectGroup.find(#{@group.id}).users.count", 2 do
        post :add_users, :project_id => @project, :id => @group, :user_ids => ['2', '3']
      end
    end
  end

  context "POST remove_users" do
    should "remove users" do
      assert_difference "ProjectGroup.find(#{@group.id}).users.count", -1 do
        post :remove_user, :project_id => @project, :id => @group, :user_id => @member.id
      end
    end
  end

  context "POST create" do
    should "create new manageable group" do
      assert_difference 'ProjectGroup.count', 1 do
        post :create, :project_id => @project, :project_group => {:lastname => 'New project group'}
      end
      assert_true ProjectGroupScope.last.manageable, "Group should be manageable when created in the project"
      #assert_redirected_to ''
    end
  end

  context "DELETE destroy" do
    should "remove group" do
      assert_difference 'ProjectGroup.count', -1 do
        post :destroy, :project_id => @project, :id => @group
      end
    end
  end

  context "#authorize_manageable" do
    setup do
      @project_group_scope.manageable = false
      @project_group_scope.save!
    end

    {:edit => :get, :update => :put, :remove_user => :post, :add_users => :post}.each do |action, verb|
      context "#{verb.to_s.upcase} #{action}" do
        setup do
          self.send verb, action, :project_id => @project, :id => @group
        end
        should_respond_with 403 # access denied
      end
    end

    {:show => :get, :new => :get, :create => :post}.each do |action, verb|
      context "#{verb.to_s.upcase} #{action}" do
        setup do
          self.send verb, action, :project_id => @project, :id => @group
        end
        should_respond_with :success
      end
    end


  end


end
