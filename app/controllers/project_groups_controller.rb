class ProjectGroupsController < ApplicationController
  unloadable
  model_object ProjectGroup
  before_filter :find_project_by_project_id
  before_filter :authorize
  before_filter :find_model_object, :except => [:create] #assigns @project_group

  #before_filter :authorize_manageable

  def show
  end

  def edit
    load_users
  end

  def create
  end

  def add_users
    users = User.find_all_by_id(params[:user_ids])
    @project_group.users << users if request.post?
    load_users
    respond_to do |format|
      format.html { redirect_to :controller => 'project_groups', :action => 'edit', :id => @project_group, :tab => 'users' }
      format.js {
        render(:update) { |page|
          page.replace_html "tab-content-users", :partial => 'project_groups/users'
          users.each { |user| page.visual_effect(:highlight, "user-#{user.id}") }
        }
      }
    end
  end

  def remove_user
    @project_group.users.delete(User.find(params[:user_id])) if request.post?
    load_users
    respond_to do |format|
      format.html { redirect_to :controller => 'project_groups', :action => 'edit', :id => @group, :tab => 'users' }
      format.js { render(:update) { |page| page.replace_html "tab-content-users", :partial => 'project_groups/users' } }
    end
  end

  protected

  def load_users
    @users_not_in_group = User.active.not_in_group(@project_group).all(:limit => 100)
  end

  def authorize_manageable
    #TODO
    true
  end
end
