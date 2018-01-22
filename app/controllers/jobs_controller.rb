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
        @job = Job.where(status: 0).order(updated_at: :desc).page(params[:page]).per(16)
    end
    
	def create
		@new_job = current_user.jobs.new(job_params)
		@new_job.save
		redirect_to "/"
    end

    def update
        @reserve_job = Job.find_by(id: params[:id])

        if @reserve_job.status == "Accepted" && @reserve_job.affiliate_id != nil
            @reserve_job.update(status: 2)
        else
            @reserve_job.update(status: 1, affiliate_id: current_affiliate.id)
        end

        redirect_to "/jobs/#{params[:id]}"
    end

    def payment
        @client_token = Braintree::ClientToken.generate
    end

    # def checkout
    #     nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    #     result = Braintree::Transaction.sale(
    #       :amount => "#{@reservation.total_price}",
    #       :payment_method_nonce => 'fake-valid-nonce',
    #       :options => {
    #         :submit_for_settlement => true
    #       }
    #     )

    #     if result.success?
    #         @reservation.paid!

    #         UserMailer.payment_email(current_user.name, current_user.email, @reservation.listing.listing_name).deliver
    #         redirect_to :root, :flash => { :success => "Transaction successful!"}
    #     else
    #         redirect_to :root, :flash => { :error => "Transaction failed. Please try again."}
    #     end         
    # end

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
