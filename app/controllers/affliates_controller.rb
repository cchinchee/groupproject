class AffiliatesController < ApplicationController
	has_secure_password

	def sign_in

	end

	def sign_up
		render "/views/affiliates/new"
	end

	def sign_out
		session.clear
		redirect_to root_path
	end
end
