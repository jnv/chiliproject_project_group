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

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    respond_to do |format|
      if @project_group.update_attributes(params[:project_group])
        flash[:notice] = l(:notice_successful_update)
        format.html { redirect_to(edit_project_group_url(@project, @project_group, :tab => 'general')) }
        format.xml { head :ok }
      else
        load_users
        format.html { render :action => "edit", :tab => 'general' }
        format.xml { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def add_users
    users = User.find_all_by_id(params[:user_ids])
    @project_group.users << users if request.post?
    respond_to do |format|
      format.html { redirect_to :controller => 'project_groups', :action => 'edit', :id => @project_group, :tab => 'users' }
      format.js {
        load_users
        render(:update) { |page|
          page.replace_html "tab-content-users", :partial => 'project_groups/users'
          users.each { |user| page.visual_effect(:highlight, "user-#{user.id}") }
        }
      }
    end
  end

  def remove_user
    @project_group.users.delete(User.find(params[:user_id])) if request.post?
    respond_to do |format|
      format.html { redirect_to :controller => 'project_groups', :action => 'edit', :id => @group, :tab => 'users' }
      format.js {
        load_users
        render(:update) { |page|
          page.replace_html "tab-content-users", :partial => 'project_groups/users' }
      }
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
