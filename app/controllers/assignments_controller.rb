class AssignmentsController < ApplicationController
  before_action :set_assignment, only: %i[ show edit update destroy ]

  # GET /assignments
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1
  def show
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  def create
    @assignment = Assignment.new(assignment_params)

    if @assignment.save
      redirect_to @assignment, notice: "Assignment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /assignments/1
  def update
    if @assignment.update(assignment_params)
      redirect_to @assignment, notice: "Assignment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /assignments/1
  def destroy
    @assignment.destroy
    redirect_to assignments_url, notice: "Assignment was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assignment_params
      params.require(:assignment).permit(:name, :description, :due_date, :course_id)
    end
end
