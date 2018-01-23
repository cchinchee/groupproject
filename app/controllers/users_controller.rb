class UsersController < ApplicationController
	# before_action :find_user, only [:show, :edit, :update, :destroy]
    
	def index
		@job = Job.where(status: 0).order(updated_at: :desc).page params[:page]
		render 'layouts/homepage'
	end

	def create
		@user = User.new(user_params)
		@user.save
		redirect_to "/"
	end

	def show
		@user = User.find_by(id: params[:id])
		@job = Job.where(user_id: params[:id]).where.not(status: "completed").order(updated_at: :desc).page(params[:page]).per(4)
		@completedjob = Job.where(user_id: params[:id], status: "completed")
		render 'users/show'
	end

	def check
		selected_state = CS.get(:my).find do |key, value| value == params[:chosenState] end
		selected_state = selected_state[0]

		allCities = CS.get(:my, selected_state)

		render json: {available_cities: allCities}.to_json
	end

	private

	def find_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :phone, :address, :city, :state, :postcode, :password, :users_avatar)
	end

end