class Clients::SessionsController < Devise::SessionsController

  # GET /resource/sign_in
  #def new
  #  self.resource = resource_class.new(sign_in_params)
  #  clean_up_passwords(resource)
  #  yield resource if block_given?
  #  respond_with(resource, serialize_options(resource))
  #end

  # POST /resource/sign_in
  def create
    resource = Client.find_for_database_authentication(email: params[:client][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:client][:password])
      sign_in :client, resource
      render nothing: true
    else
      invalid_login_attempt
    end
  end

  # DELETE /resource/sign_out
  #def destroy
  #  signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
  #  set_flash_message! :notice, :signed_out if signed_out
  #  yield if block_given?
  #  respond_to_on_destroy
  #end

  protected

  #def sign_in_params
  #  devise_parameter_sanitizer.sanitize(:sign_in)
  #end

  #def serialize_options(resource)
  #  methods = resource_class.authentication_keys.dup
  #  methods = methods.keys if methods.is_a?(Hash)
  #  methods << :password if resource.respond_to?(:password)
  #  { methods: methods, only: [:password] }
  #end

  #def auth_options
  #  { scope: resource_name, recall: "#{controller_path}#new" }
  #end

  #def translation_scope
  #  'devise.sessions'
  #end

  def invalid_login_attempt
    set_flash_message(:alert, :invalid)
    render json: {error: "invalid credentials"}, status: 401
  end

  private

  # Check if there is no signed in user before doing the sign out.
  #
  # If there is no signed in user, it will set the flash message and redirect
  # to the after_sign_out path.

  #def verify_signed_out_user
  #  if all_signed_out?
  #    set_flash_message! :notice, :already_signed_out
  #    respond_to_on_destroy
  #  end
  #end

  #def all_signed_out?
  #  users = Devise.mappings.keys.map { |s| warden.user(scope: s, run_callbacks: false) }
  #  users.all?(&:blank?)
  #end

  #def respond_to_on_destroy
  #  # We actually need to hardcode this as Rails default responder doesn't
  #  # support returning empty response on GET request
  #  respond_to do |format|
  #    format.all { head :no_content }
  #    format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
  #  end
  #end
end