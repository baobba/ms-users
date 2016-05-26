require 'rails_helper'

RSpec.describe Api::V1::EnterprisesController, type: :controller do

  describe "GET #index" do
    it "returns http success as client admin" do
      client_admin_sign_in
      get :index, {format: :json}
      expect(response).to have_http_status(:success)
    end
    it "returns http unauthorized as common client" do
    	client_sign_in
      get :index, {token: "sampletoken", format: :json}
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST #create" do
    it "returns http created for logged client" do
      client_sign_in

      enterprise_attrs = FactoryGirl.attributes_for(:enterprise)

      post :create, enterprise: enterprise_attrs, format: :json
      expect(response).to have_http_status(:created)
    end
    it "returns http unauthorized for guest client" do
      client_sign_in nil

      enterprise_attrs = FactoryGirl.attributes_for(:enterprise)

      post :create, enterprise: enterprise_attrs, format: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PATCH #update" do
    it "returns http success for logged client's object" do
    	current_client = client_sign_in

    	# Must create this way, because FactoryGirl.create(:enterprise) also creates another user,
    	# which will have a different 'id' compared to our current_client
      enterprise_attrs = FactoryGirl.attributes_for(:enterprise)
      enterprise_attrs[:client_id] = current_client.id
      enterprise = Enterprise.create!(enterprise_attrs)

      new_attrs = FactoryGirl.attributes_for(:enterprise)
      patch :update, enterprise: new_attrs, id: enterprise.slug, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http no_content" do
    	current_client = client_sign_in

    	# Must create this way, because FactoryGirl.create(:enterprise) also creates another user,
    	# which will have a different 'id' compared to our current_client
      enterprise_attrs = FactoryGirl.attributes_for(:enterprise)
      enterprise_attrs[:client_id] = current_client.id
      enterprise = Enterprise.create!(enterprise_attrs)

      get :destroy, id: enterprise.slug
      expect(response).to have_http_status(:no_content)
    end
  end

end
