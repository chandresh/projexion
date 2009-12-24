class ProjectsController < ApplicationController
  layout 'main'
  respond_to :html, :json
  
  def index
    @projects = Project.find(:all)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])

    respond_with(@project) do |format|
      if @project.save
        format.html { redirect_to project_path(@project.code), :notice => 'Project was successfully added.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def show
    @project = Project.find_by_code(params[:code])

    # TODO: Only show not accepted features
    @features = @project.features

    @releases = @project.releases

    @sprints = @project.sprints

    respond_with(@project, @features)
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    respond_with(@project) do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to project_path(@project.code), :notice => 'Project was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_path, :notice => 'Project was successfully deleted.' }
    end
  end

end
