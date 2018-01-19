class JobsController < ApplicationController
	
	def create
		@job = Job.new(job_params)
		@job.save
		redirect_to "/"
	end
    
private
    def job_params
        params.require(:job).permit(:name, :category, :start_date, :end_date, :description, :price, :review, :address, :states, :city, :postcode)
    end
end
