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
      @project.reload
      @group.reload
      get :edit, :project_id => @project, :id => @group
    end

    should_assign_to(:project_group) { @group }

    should "assign to @users_not_in_group" do
      assert_include(assigns(:users_not_in_group), @nonmember)
      assert_not_include(assigns(:users_not_in_group), @member)
    end


  end

end
