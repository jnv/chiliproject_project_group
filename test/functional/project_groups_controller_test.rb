require File.expand_path('../../test_helper', __FILE__)

class ProjectGroupsControllerTest < ActionController::TestCase
  setup do
    @controller = ProjectGroupsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    Setting.default_language = 'en'
    @request.session[:user_id] = 2 # manager

    @group = ProjectGroup.generate!
  end

  context "GET show" do
    setup do
      get :show, @group
    end

    should_assign_to :project_group

  end


end
