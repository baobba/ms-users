require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do
  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:api_v1_user]
  end

  describe "POST #create" do
    it "returns http created for valid app token" do
      app = FactoryGirl.create(:app)
      user_attrs = FactoryGirl.attributes_for(:user)

      post :create, user: user_attrs, token: app.api_token.token
      expect(response).to have_http_status(:created)
    end
    it "returns http unauthorized for invalid app token" do
      app = FactoryGirl.create(:app)
      user_attrs = FactoryGirl.attributes_for(:user)

      post :create, user: user_attrs, token: "sampletoken"
      expect(response).to have_http_status(:unauthorized)
    end
  end

end
