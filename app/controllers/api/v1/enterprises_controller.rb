class Api::V1::EnterprisesController < Api::V1::BaseController
	before_action :restrict_logged_client, only: [:create]
	before_action :restrict_logged_client_self, only: [:update, :delete]
	before_action :restrict_logged_client_admin, only: [:index]

  def enterprise_params
    p = params.require(:enterprise).permit(:name, :home_url, :facebook_id, :facebook_key, :linkedin_id, :linkedin_key, :google_id, :google_key, :github_id, :github_key, :twitter_id, :twitter_key)
		p[:client_id] = current_client.id
		return p
  end
end
