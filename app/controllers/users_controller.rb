module Api
	module V1
		class UsersController < ApplicationController
			def destroy
			end

			def update
			end

			def index
				@user = User.all.load

				respond_to do |format|
					format.json{ render json: @user }
				end
			end

			def show
			end

			def create
			end

			def user_params
				parms.require(:user).permit(:email, :lat, :long, :sex, device_attributes: [:token, :platform, :enabled])
			end
			
		end
	end
end
