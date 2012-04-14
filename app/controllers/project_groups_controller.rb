class ProjectGroupsController < ApplicationController
  #unloadable
  model_object ProjectGroup
  before_filter :find_project_by_project_id #, :only => :new
  #before_filter :find_model_object, :except => :new
  #before_filter :find_project_from_association, :except => :new
  #before_filter :authorize


  def show
    @project_group = ProjectGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project_group }
    end
  end

  def new
  end

  def create
  end

  def add_users
  end

  def remove_users
  end
end
