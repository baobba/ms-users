class Api::V1::EnterprisesController < Api::V1::BaseController
	before_action :verify_jwt_token
	#before_action :restrict_logged_client, only: [:create, :index]
	before_action :restrict_logged_client_self, only: [:update, :delete]
	#before_action :restrict_logged_client_admin, only: [:index]

	def index
		if current_client.role == "admin"
			@enterprises = Enterprise.where(query_params)
																.page(page_params[:page])
																.per(page_params[:page_size])
		else
			@enterprises = Enterprise.where(client_id: current_client.id)
																.page(page_params[:page])
																.per(page_params[:page_size])
		end

		respond_with @enterprises
	end

  def enterprise_params
    p = params.require(:enterprise).permit(:name, :domain, :home_url, :facebook_id, :facebook_key, :linkedin_id, :linkedin_key, :google_oauth2_id, :google_oauth2_key, :github_id, :github_key, :twitter_id, :twitter_key)
		p[:client_id] = current_client.id
		return p
  end
end
