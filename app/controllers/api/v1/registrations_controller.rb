# Only Create is handled here
class Api::V1::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]
  before_action :require_valid_app_token, only: [:create]
  respond_to :json
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def sign_up_params
    p = params.require(:user).permit(:email, :password, :password_confirmation)
    p[:uattr] = params[:user][:uattr]
    p[:app_id] = ApiToken.where(token: params[:token]).first.app_id
    return p
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_inactive_sign_up_path_for(resource)
  #   "/api/v1/users/" + resource.uuid + "?token=" + params[:token]
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def respond_with(resource, opts = {})
    render json: resource, status: :created # Triggers the appropriate serializer
  end
  def require_valid_app_token
    head :unauthorized unless ApiToken.where(token: params[:token]).first.present?
  end
end
