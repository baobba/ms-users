class Api::V1::UsersController < Api::V1::BaseController
	before_action :restrict_access, except: [:setup]
	before_action :restrict_admin, only: [:index]
	before_action :restrict_self, only: [:show, :update, :delete]

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
end
