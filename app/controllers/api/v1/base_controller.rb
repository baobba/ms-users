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

  # GET /api/{plural_resource_name}/mock
  def mock
    mp = params[:model].pluralize
    path = '/api/v1/' + mp + '/mock'
    render path
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
    def restrict_logged_client cascade = false
      if current_client
        return true
      else
        head :unauthorized if !cascade
        return false
      end
    end
    def restrict_logged_client_admin cascade = false
      if current_client.try(:role) == "admin"
        return true
      else
        head :unauthorized if !cascade
      end
    end
    def restrict_logged_client_self cascade = false
      if restrict_logged_client(true) && get_resource.try(:client_id).present? && get_resource.try(:get_client_id) == current_client.id
        return true
      else
        head :unauthorized if !cascade
        return false
      end
    end

    def restrict_access cascade = false
      if ApiToken.where(token: get_token()).exists?
        return true
      else
        head :unauthorized if !cascade
        return false
      end
    end
    def restrict_admin cascade = false
      role = ApiToken.where(token: get_token()).first.try(:role)
      if role == "admin" || restrict_logged_client_admin(true)
        return true
      else
        head :unauthorized if !cascade
        return false
      end
    end
    def restrict_self cascade = false
      api_token = ApiToken.where(token: get_token()).first
      app_id = api_token.try(:app_id)
      if (app_id != nil && get_resource.try(:get_app_id) == app_id) || restrict_admin(true)
        return true
      else
        head :unauthorized if !cascade
        return false
      end
    end

  private
    def get_token
      return params[:token] || request.headers["token"]
    end
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

    # Returns the allowed parameters for paclientgination
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
        if params[:id].present?
          resource ||= resource_class.find(params[:id])
        elsif params[:uuid].present?
          resource ||= resource_class.find_by(uuid: params[:uuid])
        end
        instance_variable_set("@#{resource_name}", resource)
      rescue
        head :not_found
      end
    end

end
