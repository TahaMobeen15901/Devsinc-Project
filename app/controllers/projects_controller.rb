class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show
    @bugs=@project.bugs
  end

  # GET /projects/new
  def new
    @project = Project.new
    authorize @project
  end

  # GET /projects/1/edit
  def edit
    @invalid_users = @project.users.where.not(role: :manager)
    @valid_users = User.where.not(role: :manager)- @invalid_users
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(title: params[:project][:title])
    authorize @project
    @project.users << current_user
    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_url, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    if params[:project][:new_users]!= "" then
      @project.users << User.find(params[:project][:new_users])
    end
    if params[:project][:remove_users] != "" then
      @project.users.delete(User.find(params[:project][:remove_users]))
    end
    respond_to do |format|
      if @project.update(title: params[:project][:title])
        format.html { redirect_to projects_url, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  private
  def set_project
    @project=Project.find(params[:id])
    authorize @project
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.permit(:id, :title, :new_users, :remove_users)
  end

end
