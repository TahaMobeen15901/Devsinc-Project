class BugsController < ApplicationController
  before_action :set_bug, only: %i[ show edit update destroy ]
  before_action :bug_expired, only: %i[ show edit update destroy ]

  # GET /bugs or /bugs.json
  def index
    @bugs = Bug.all
  end

  # GET /bugs/1 or /bugs/1.json
  def show
  end

  # GET /bugs/new
  def new
    @bug = Bug.new
    authorize @bug
    @creator = params[:creator_id]
    @project= params[:project_id]
  end

  # GET /bugs/1/edit
  def edit
    @edit_type=params[:edit_type]
    @bug = Bug.find(params[:id])
    @project = Project.find(params[:project_id])
    if @bug.bug_type == "Bug" then
      @final_status = "Resolved"
    else
      @final_status = "Completed"
    end
  end

  # POST /bugs or /bugs.json
  def create
    @bug = Bug.new(
      title: params[:bug][:title],
      deadline: params[:bug][:deadline],
      image: params[:bug][:image],
      bug_type: params[:bug][:bug_type],
      types_status: params[:bug][:types_status]
    )
    authorize @bug
    Project.find(params[:bug][:project_id]).bugs <<@bug
    User.find(params[:bug][:creator]).created_bugs <<@bug
    respond_to do |format|
      if @bug.save
        format.html { redirect_to project_path(:id => params[:bug][:project_id]), flash[:notice] = "Bug was successfully created." }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bugs/1 or /bugs/1.json
  def update
    respond_to do |format|
      if @bug.update(types_status: params[:bug][:types_status])
        format.html { redirect_to project_path(:id => params[:bug][:project_id]), flash[:notice] = "Bug was successfully updated." }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bugs/1 or /bugs/1.json
  def destroy
    @bug.destroy

    respond_to do |format|
      format.html { redirect_to bugs_url, flash[:notice] = "Bug was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bug
      @bug = Bug.find(params[:id])
      authorize @bug
    end

    def bug_expired
      @curr = Bug.find(params[:id])
      if (@curr.deadline> Date.today) or (@curr.types_status != "new" and @curr.types_status != "started")then
        @curr.destroy
        respond_to do |format|
          format.html { redirect_to bugs_url, flash[:notice] = "Bug was successfully destroyed." }
          format.json { head :no_content }
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def bug_params
      params.require(:bug).permit(:creator, :title, :deadline, :bug_type, :image, :types_status, :project_id)
    end
end
