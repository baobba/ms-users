require 'rails_helper'

RSpec.describe Api::V1::AppsController, type: :controller do

  describe "GET #index" do
    it "returns http success with admin token" do
      admin = FactoryGirl.create(:app_admin)
      get :index, {token: admin.api_token.token, format: :json}
      expect(response).to have_http_status(:success)
    end
    it "returns http unauthorized without admin token" do
      get :index, {token: "sampletoken", format: :json}
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST #create" do
    it "returns http created for logged client" do
      client_sign_in
      enterprise = FactoryGirl.create(:enterprise)
      app_attrs = FactoryGirl.attributes_for(:app)
      app_attrs[:enterprise_id] = enterprise.slug

      post :create, app: app_attrs, format: :json
      expect(response).to have_http_status(:created)
    end
    it "returns http unauthorized for guest client" do
      client_sign_in nil
      enterprise = FactoryGirl.create(:enterprise)
      app_attrs = FactoryGirl.attributes_for(:app)
      app_attrs[:enterprise_id] = enterprise.slug

      post :create, app: app_attrs, format: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PATCH #update" do
    it "returns http success" do
      app = FactoryGirl.create(:app)
      new_attrs = FactoryGirl.attributes_for(:app)
      patch :update, app: new_attrs, id: app.slug, token: app.api_token.token, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http no_content" do
      app = FactoryGirl.create(:app)
      get :destroy, id: app.slug
      expect(response).to have_http_status(:no_content)
    end
  end

end
