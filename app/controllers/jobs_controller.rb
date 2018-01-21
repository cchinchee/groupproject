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

    def show_all_job
        @job = Job.order(updated_at: :desc).page(params[:page]).per(16)
    end
    
	def create
		@new_job = current_user.jobs.new(job_params)
		@new_job.save
		redirect_to "/"
    end

    def update
        @reserve_job = Job.find_by(id: params[:id])
        @reserve_job.update(status: 1)
        redirect_to "/jobs/#{params[:id]}"
    end

    def check
        case params[:chosenCategory]
        when "Cleaning Service"
            price = 80
        when "Catering Service"
            price = 100
        when "Mobile and Laptop Repair"
            price = 150
        when "Home Maintenance"
            price = 60
        when "Movers"
            price = 70
        when "Plumbing Service"
            price = 60
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
