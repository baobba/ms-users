require "#{Rails.root}/spec/support/omniauth_macros.rb"
include OmniauthMacros

FactoryGirl.define do
  factory :identity do
  	sequence(:oauth_hash){|n| (valid_login_setup :facebook, rand(100000)).to_json}
  	provider				:facebook
  	user

	  before(:create) do |identity|
	  	identity.uid = JSON.parse(identity.oauth_hash)["uid"]
	  end
  end
end
