class Api::V1::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    flash[:info] = 'Not available'
    redirect_to root_path
  end

  # POST /resource/sign_in
  def create
    flash[:info] = 'Not available'
    redirect_to root_path
  end

  # DELETE /resource/sign_out
  def destroy
    flash[:info] = 'Not available'
    redirect_to root_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
