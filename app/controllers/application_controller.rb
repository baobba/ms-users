class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def verify_jwt_token
  	return true if current_client
  	
  	if request.headers['Authorization'].nil? ||
  		!AuthToken.valid?(request.headers['Authorization'].split(' ').last)
  		head :unauthorized
  	else
  		data = AuthToken.get_data(request.headers['Authorization'].split(' ').last)
  		c = Client.find(data["client_id"])
  		sign_in(:client, c)
  	end

  end

  def not_found
		raise ActionController::RoutingError.new('Not Found')
	end
end
