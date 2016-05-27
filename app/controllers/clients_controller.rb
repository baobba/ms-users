class ClientsController < Api::V1::BaseController
	before_action :restrict_logged_client_admin

  def gen_token
  	registration_token = RegistrationToken.create!(registration_token_params)
  	render json: {token: registration_token.token, expires_at: registration_token.expires_at}, status: :created
  end
  def registration_token_params
  	params.permit(:expires_at)
  end
  def client_params
  	params.permit!
  end
end
