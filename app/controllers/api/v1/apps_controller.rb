class Api::V1::AppsController < Api::V1::BaseController
	before_action :verify_jwt_token_or_api_token

	before_action :restrict_logged_client, only: [:create]
	before_action :restrict_self_enterprise, only: [:index, :create]
	before_action :restrict_self, only: [:show, :update, :delete]

	def verify_jwt_token_or_api_token
		if params[:token].nil?
			verify_jwt_token
		end
	end
	def restrict_self_enterprise cascade = false
		enterprise_id = begin
			params[:app][:enterprise_id]
		rescue
			nil
		end
		if (current_client.try(:id) != nil && enterprise_id.present? && Enterprise.find(enterprise_id).try(:client_id) == current_client.id) || restrict_admin(true)
			return true
		else
			head :unauthorized if !cascade
			return true
		end
	end

	def app_params
		params.require(:app).permit(:name, :domain, :callback, :enterprise_id)
	end
	def query_params
		params.permit(:enterprise_id, :name, :domain, :callback)
	end

end
