class Api::V1::UsersController < Api::V1::BaseController
	before_action :restrict_access, except: [:setup]
	before_action :restrict_admin, only: [:index]
	before_action :restrict_self, only: [:show, :update, :delete]

	# Create is not handled here

	def setup
		session[:app_id] ||= params[:id]
		app = App.find(session[:app_id])
		id = app.enterprise[params[:provider] + "_id"]
		token = app.enterprise[params[:provider] + "_key"]

		if params[:provider] == "twitter"
			env['omniauth.strategy'].options[:consumer_key] = id
			env['omniauth.strategy'].options[:consumer_secret] = token
		else
			env['omniauth.strategy'].options[:client_id] = id
			env['omniauth.strategy'].options[:client_secret] = token
		end
		render nothing: true, status: 404
	end

	def logged
		decoded_jwt = JWT.decode params[:jwt_token], params[:token], true, {algorithm: 'HS256'}
		
		user = User.where(uuid: decoded_jwt[0]["uuid"]).first
		if user.nil?
			head :not_found
		else
			head :ok
		end
	end

	def authenticate
		if params[:uid].present? # authenticate via social media.
			identity = Identity.where(uid: params[:uid]).first
			user = identity.try(:user)
		elsif params[:email].present? # authenticate with email and password
			user = User.where(email: params[:email]).first
			user = nil if user.try(:valid_password?, params[:password]) == false
		end
		######################################
		if user.nil?
			head :not_found
		else
			render json: {uuid: user.uuid}, status: :ok
		end	
	end

	def user_params
		p = params.require(:user).permit(:email, :password, :password_confirmation)
		p[:uattr] = params[:user][:uattr]
		return p
	end
end
