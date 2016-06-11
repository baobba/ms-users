require "#{Rails.root}/spec/support/omniauth_macros.rb"
include OmniauthMacros

FactoryGirl.define do
	oah = valid_login_setup :facebook

  factory :identity do
  	oauth_hash			oah.to_json
  	provider				:facebook
  	uid							oah.uid
  	user
  end
end
