class JobsController < ApplicationController
	
    def index
    end
    
    def new
        @job = Job.all
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
end
