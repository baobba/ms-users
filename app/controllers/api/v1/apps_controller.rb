class Api::V1::AppsController < Api::V1::BaseController
	before_action :restrict_logged_client, only: [:create]
	before_action :restrict_self_enterprise, only: [:create]
	before_action :restrict_admin, only: [:index]
	before_action :restrict_self, only: [:show, :update, :delete]

	def restrict_self_enterprise
		head :unauthorized unless Enterprise.find(app_params[:enterprise_id]).client_id == current_client.id
	end

	def app_params
		params.require(:app).permit(:name, :domain, :callback, :enterprise_id)
	end
end
