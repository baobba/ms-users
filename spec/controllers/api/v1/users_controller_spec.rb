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

  describe "GET #logged" do
    it "returns http success for valid params" do
      user = FactoryGirl.create(:user)
      api_token = user.app.api_token.token

      payload = {uuid: user.uuid}
      jwt_token = JWT.encode payload, api_token, 'HS256'

      get :logged, jwt_token: jwt_token, token: api_token
      expect(response).to have_http_status(:success)
    end
    it "returns not found for invalid params" do
      user = FactoryGirl.create(:user)
      api_token = user.app.api_token.token

      payload = {uuid: "an_incorrect_uuid"}
      jwt_token = JWT.encode payload, api_token, 'HS256'

      get :logged, jwt_token: jwt_token, token: api_token
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST #authenticate" do
    it "returns http success for valid identity uid and provider" do
      identity = FactoryGirl.create(:identity)
      api_token = identity.user.app.api_token.token

      post :authenticate, uid: identity.uid, provider: identity.provider, token: api_token, format: :json
      expect(response).to have_http_status(:success)

      parsed_resp = JSON.parse(response.body)
      expect(parsed_resp["uuid"]).to eq identity.user.uuid
    end
    it "returns http not found for invalid uid" do
      identity = FactoryGirl.create(:identity)
      api_token = identity.user.app.api_token.token

      post :authenticate, uid: "sampleuid", provider: identity.provider, token: api_token
      expect(response).to have_http_status(:not_found)
    end
    it "returns http success for valid email and password" do
      user = FactoryGirl.create(:user)

      pswd = "1234567"

      user.password = pswd
      user.password_confirmation = pswd
      user.save!

      api_token = user.app.api_token.token

      post :authenticate, email: user.email, password: pswd, token: api_token, format: :json
      expect(response).to have_http_status(:success)

      parsed_resp = JSON.parse(response.body)
      expect(parsed_resp["uuid"]).to eq user.uuid
    end
    it "returns http not found for invalid email and password" do
      user = FactoryGirl.create(:user)

      pswd = "1234567"

      user.password = pswd
      user.password_confirmation = pswd
      user.save!

      api_token = user.app.api_token.token

      post :authenticate, email: user.email, password: pswd + "x", token: api_token
      expect(response).to have_http_status(:not_found)
    end
  end

end
