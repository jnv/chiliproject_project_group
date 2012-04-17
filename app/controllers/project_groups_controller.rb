# -*- encoding : utf-8 -*-
class ProjectGroupsController < ApplicationController
  unloadable
  model_object ProjectGroup
  before_filter :find_project_by_project_id
  before_filter :authorize
  before_filter :find_model_object, :except => [:new, :create] #=> @project_group
  before_filter :authorize_manageable, :except => [:new, :create, :show]

  def show
  end

  def edit
    load_users
  end

  def new
    @project_group = ProjectGroup.new(:projects => [@project])
  end

  def create
    @project_group = ProjectGroup.new(params[:project_group])
    @project_group.parent_project = @project
    @project_group.projects << @project #TODO this could be handled by model on create
    respond_to do |format|
      if @project_group.save
        # Group is manageable for the project in which was created
        flash[:notice] = l(:notice_successful_create)
        format.html { redirect_to edit_project_group_url(@project, @project_group, :tab => 'users') }
        format.xml { render :xml => @project_group, :status => :created, :location => @project_group }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @project_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project_group.update_attributes(params[:project_group])
        flash[:notice] = l(:notice_successful_update)
        format.html { redirect_to edit_project_group_url(@project, @project_group) }
        format.xml { head :ok }
      else
        load_users
        format.html { render :action => "edit", :tab => 'general' }
        format.xml { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @project_group.destroy

    respond_to do |format|
      format.html { redirect_to :controller => "projects", :action => "settings", :id => @project, :tab => "project_groups" }
      format.xml { head :ok }
    end
  end

  def add_users
    users = User.find_all_by_id(params[:user_ids])
    @project_group.users << users if request.post?
    respond_to do |format|
      format.html { redirect_to edit_project_group_url(@project, @project_group, :tab => 'users') }
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

  # Loads users not present in the group
  def load_users
    @users_not_in_group = User.active.not_in_group(@project_group).all(:limit => 100)
  end

  # Prevents access if the group is not a child of project
  def authorize_manageable
    unless @project_group.is_child_of?(@project)
      deny_access
    end
    true
  end
end
