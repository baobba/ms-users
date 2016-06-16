require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

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

  describe "PATCH #update" do
    it "returns http success" do
      user = FactoryGirl.create(:user)
      new_attrs = {email: "sampleemail@email.com"}
      patch :update, user: new_attrs, uuid: user.uuid, token: user.app.api_token.token, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http no_content" do
      user = FactoryGirl.create(:user)
      get :destroy, uuid: user.uuid, token: user.app.api_token.token
      expect(response).to have_http_status(:no_content)
    end
  end

end
