class SubmissionsController < ApplicationController
  before_action :set_submission, only: %i[show edit update destroy]

  # GET /submissions
  def index
    @submissions = Submission.all
  end

  # GET /submissions/1
  def show
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      redirect_to @submission, notice: "Submission was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /submissions/1
  def update
    if @submission.update(submission_params)
      redirect_to @submission, notice: "Submission was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /submissions/1
  def destroy
    @submission.destroy
    redirect_to submissions_url,
                notice: "Submission was successfully destroyed.",
                status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_submission
    @submission = Submission.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def submission_params
    params.require(:submission).permit(
      :assignment_id,
      :student_id,
      :submitted_at,
      :file_path
    )
  end
end
