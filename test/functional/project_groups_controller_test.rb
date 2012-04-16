require File.expand_path('../../test_helper', __FILE__)

class ProjectGroupsControllerTest < ActionController::TestCase

  fixtures :projects, :users, :member_roles, :members


  def setup
    @controller = ProjectGroupsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    Setting.default_language = 'en'

    Role.find(1).add_permission! :manage_project_groups
    @request.session[:user_id] = 2 # manager, member of Project 1

    @project = Project.find(1)
    @group = ProjectGroup.generate!(:projects => [@project])

    @member = User.generate!
    @group.users << @member

    @nonmember = User.generate!
  end

  context "GET show" do
    setup do
      get :show, :project_id => @project, :id => @group
    end

    should_assign_to(:project_group) { @group }
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
      assert_difference "Group.find(#{@group.id}).users.count", 2 do
        post :add_users, :project_id => @project, :id => @group, :user_ids => ['2', '3']
      end
    end
  end

  context "POST remove_users" do
    should "remove users" do
      assert_difference "Group.find(#{@group.id}).users.count", -1 do
        post :remove_user, :project_id => @project, :id => @group, :user_id => @member.id
      end
    end
  end


end
