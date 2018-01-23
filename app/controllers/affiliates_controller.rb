class AffiliatesController < ApplicationController

	def sign_in
		@affiliate = Affiliate.find_by(email: params[:session][:email])
		if @affiliate && @affiliate.authenticate(params[:session][:password])
			session[:affiliate_id] = @affiliate.id
			redirect_to job_show_all_job_path
		else
			redirect_to root_path
		end 
	end

	def show
		@affiliate = Affiliate.find_by(id: params[:id])
		@job = Job.where(affiliate_id: params[:id])
		@upcomingjob = @job.where(status: 1).order(updated_at: :desc).page(params[:page]).per(4)
		@completedjob = @job.where(status: 2).order(updated_at: :desc).page(params[:page]).per(4)
		@review = @job.where(status:3)
		@pension = @job.where(status:3)
		fee = 0
		@review.each do |t|
			fee += (t.price) *0.87
		end
		@fee = fee

		pension = 0
		@pension.each do |t|
			pension += (t.price) *0.08
		end
		@pension = pension

	end


	def create
		@new_affiliate = Affiliate.new(affiliate_params)
		if @new_affiliate.save
			session[:affiliate_id] = @new_affiliate.id
			redirect_to root_path
		else
			render "/affiliates/new"
		end
	end

	def sign_up
		
	end

	def sign_out
		session.clear
		redirect_to root_path
	end

	def statement
		render "/affiliates/statement"
	end	
end

private
def affiliate_params
	params.require(:affiliate).permit(:first_name, :last_name, :password, :email, :phone, :address, :city, :postcode, :state, {verification_documents: []})
end
