class Api::V1::UsersController < Api::V1::BaseController
	before_action :restrict_access, except: [:setup]
	before_action :restrict_admin, only: [:index]
	before_action :restrict_self, only: [:show, :update, :delete]

	def user_params
		params.require(:user).permit(attrs: {})
	end
end
