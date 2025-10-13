class JobApplicationsController < ApplicationController
  before_action :set_job_application, only: [:show, :edit, :update, :destroy]

  # GET /job_applications
  def index
    @job_applications = JobApplication.recent
  end

  # GET /job_applications/1
  def show
  end

  # GET /job_applications/new
  def new
    @job_application = JobApplication.new
  end

  # GET /job_applications/1/edit
  def edit
  end

  # POST /job_applications
  def create
    @job_application = JobApplication.new(job_application_params)

    if @job_application.save
      redirect_to job_applications_path, notice: "Job application was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /job_applications/1
  def update
    if @job_application.update(job_application_params)
      redirect_to @job_application, notice: "Job application was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /job_applications/1
  def destroy
    @job_application.destroy!
    redirect_to job_applications_path, notice: "Job application was successfully deleted."
  end

  private
    def set_job_application
      @job_application = JobApplication.find(params[:id])
    end

    def job_application_params
      params.require(:job_application).permit(
        :company_name,
        :job_title,
        :application_link,
        :application_date,
        :current_status,
        :rejected_at_stage,
        :salary_range_min,
        :salary_range_max,
        :contact_name,
        :contact_email,
        :notes,
        :follow_up_date
      )
    end
end
