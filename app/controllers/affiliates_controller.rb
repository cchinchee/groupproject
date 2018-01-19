class AffiliatesController < ApplicationController

	def sign_in
		render "/affiliates/signin"
	end

	def sign_up
		render "/affiliates/new"
	end

	def sign_out
		session.clear
		redirect_to root_path
	end
end
