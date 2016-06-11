require 'spec_helper'
require "#{Rails.root}/spec/support/omniauth_macros.rb"
include OmniauthMacros

RSpec.describe "GET /api/v1/users/auth/facebook/callback" do
	before(:each) do
		app = FactoryGirl.create(:app)
		rt = "/api/v1/users/auth/facebook?id=" + app.slug
		get rt

		valid_login_setup :facebook
		get "/api/v1/users/auth/facebook/callback"
		request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
	end

	it "should set uid" do
		identity = User.desc('_id').first.identities.where(provider: "facebook").first
		expect(identity).to be_present
		expect(identity.uid).to be_present
	end
end

RSpec.describe "GET /api/v1/users/auth/google_oauth2/callback" do
	before(:each) do
		app = FactoryGirl.create(:app)
		rt = "/api/v1/users/auth/google_oauth2?id=" + app.slug
		get rt

		valid_login_setup :google_oauth2
		get "/api/v1/users/auth/google_oauth2/callback"
		request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
	end

	it "should set uid" do
		identity = User.all.desc('_id').first.identities.where(provider: "google_oauth2").first
		expect(identity).to be_present
		expect(identity.uid).to be_present
	end
end

RSpec.describe "GET /auth/failure" do
	it "should redirect to root" do
		#get "/api/v1/users/auth/failure"
		#expect(response).to redirect_to root_path
	end
end
