class JobsController < ApplicationController
    before_action :show_job_params, only: [:show]

    def index
    end
    
    def new
        @job = Job.all
    end

    def show
        
    end
    
	def create
		@new_job = current_user.jobs.new(job_params)
		@new_job.save
		redirect_to "/"
    end
    
private
    def job_params
        params.require(:job).permit(:name, :category, :start_date, :end_date, :description, :price, :review, :address, :state, :city, :postcodes)
    end

    def show_job_params
        @job = Job.find(params[:id])
    end
end
