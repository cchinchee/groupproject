class JobsController < ApplicationController
    before_action :show_job_params, only: [:show]

    def index
    end
    
    def new
        @job = Job.all
    end

    def show
        @jobs = Job.where(id: params[:id])
        @hash = Gmaps4rails.build_markers(@jobs) do |job, marker|
            marker.lat job.latitude
            marker.lng job.longitude
        end
    end
    
	def create
		@new_job = current_user.jobs.new(job_params)
		@new_job.save
		redirect_to "/"
    end

    def check
        case params[:chosenCategory]
        when "Cleaning Service"
            price = "RM 80"
        when "Catering Service"
            price = "RM 100"
        when "Mobile and Laptop Repair"
            price = "RM 150"
        when "Home Maintenance"
            price = "RM 60"
        when "Movers"
            price = "RM 70"
        when "Plumbing Service"
            price = "RM 60"
        end

        render json: {chosenPrice: price}.to_json
    end
    
private
    def job_params
        params.require(:job).permit(:name, :category, :start_date, :start_time, :description, :price, :address, :state, :city, :postcode)
    end

    def show_job_params
        @job = Job.find(params[:id])
    end
end
