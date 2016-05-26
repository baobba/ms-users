class Api::V1::AppsController < Api::V1::BaseController
	before_action :restrict_logged_client, only: [:create]
	before_action :restrict_admin, only: [:index]
	before_action :restrict_self, only: [:show, :update, :delete]

	def app_params
		params.require(:app).permit(:name, :domain, :callback, :enterprise_id)
	end
end
