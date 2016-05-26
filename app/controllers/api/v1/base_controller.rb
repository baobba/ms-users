class Api::V1::BaseController < ApplicationController
  before_action :set_resource, only: [:destroy, :show, :update]
  respond_to :json

  # POST /api/{plural_resource_name}
  def create
    set_resource(resource_class.new(resource_params))

    if get_resource.save
      render :show, status: :created
    else
      render json: ErrorSerializer.serialize(get_resource.errors), status: :unprocessable_entity
    end
  end

  # DELETE /api/{plural_resource_name}/1
  def destroy
    get_resource.destroy
    head :no_content
  end

  # GET /api/{plural_resource_name}
  def index
    plural_resource_name = "@#{resource_name.pluralize}"
    resources = resource_class.where(query_params)
                              .page(page_params[:page])
                              .per(page_params[:page_size])

    instance_variable_set(plural_resource_name, resources)
    respond_with plural_resource_name
  end

  # GET /api/{plural_resource_name}/1
  def show
    respond_with get_resource or not_found
  end

  # PATCH/PUT /api/{plural_resource_name}/1
  def update
    get_resource.update_attributes(resource_params)
    if get_resource.save
      render :show
    else
      render json: ErrorSerializer.serialize(get_resource.errors), status: :unprocessable_entity
    end
  end

  # POST /api/{plural_resource_name}/unique
  def unique
    key = params.keys.first.to_s
    val = params.values.first.to_s
    match = nil

    resource_class.validators.each do |validator|
      if validator.kind_of? ActiveRecord::Validations::UniquenessValidator
        validator.attributes.each do |attrib|
          if attrib.to_s == key
            match = attrib
          end
        end
      end
    end
    if match == nil
      render json: {message: ["Atributo inválido para consulta"]}, status: :unprocessable_entity
    elsif resource_class.where(match => val).count > 0
      render json: {match: true}
    else
      render json: {match: false}
    end
  end

  protected
    def restrict_logged_client
      head :unauthorized unless current_client
    end
    def restrict_access
      api_token = ApiToken.where(token: params[:token]).exists?
      head :unauthorized unless api_token
    end
    def restrict_admin
      role = ApiToken.where(token: params[:token]).first.try(:role)
      head :unauthorized unless role == "admin"
    end
    def restrict_self
      api_token = ApiToken.where(token: params[:token]).first
      app_id = api_token.try(:app_id)
      head :unauthorized unless app_id != nil && ( get_resource.try(:get_app_id) == app_id ) || api_token.try(:role) == "admin"
    end

  private

    def get_resource
      instance_variable_get("@#{resource_name}")
    end

    # Returns the allowed parameters for searching
    # Override this method in each API controller
    # to permit additional parameters to search on
    # @return [Hash]
    def query_params
      {}
    end

    # Returns the allowed parameters for pagination
    # @return [Hash]
    def page_params
      params.permit(:page, :page_size)
    end

    # The resource class based on the controller
    # @return [Class]
    def resource_class
      @resource_class ||= resource_name.classify.constantize
    end

    # The singular name for the resource class based on the controller
    # @return [String]
    def resource_name
      @resource_name ||= self.controller_name.singularize
    end

    # Only allow a trusted parameter "white list" through.
    # If a single resource is loaded for #create or #update,
    # then the controller for the resource must implement
    # the method "#{resource_name}_params" to limit permitted
    # parameters for the individual model.
    def resource_params
      @resource_params ||= self.send("#{resource_name}_params")
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_resource(resource = nil)
      begin
        resource ||= resource_class.find(params[:id])
        instance_variable_set("@#{resource_name}", resource)
      rescue
        not_found
      end
    end

end
