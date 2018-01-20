class AffiliatesController < ApplicationController

	def sign_in
		@affiliate = Affiliate.find_by(email: params[:email])
		if @affiliate && @affiliate.authenticate(params[:password])
			session[:affiliate_id] = @affiliate.id
			redirect_to job_show_all_job_path
		else
			render "/affiliates/signin"
		end 
	end

	def create
		@new_affiliate = Affiliate.new(affiliate_params)
		if @new_affiliate.save
			redirect_to job_show_all_job_path
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
end

private
def affiliate_params
	params.require(:affiliate).permit(:first_name, :last_name, :password, :email, :phone, :address, :city, :postcode, :state, {verification_documents: []})
end
