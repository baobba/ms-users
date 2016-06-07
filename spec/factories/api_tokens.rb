FactoryGirl.define do
	factory :api_token do
		role ApiToken.role.values.sample
		app
	end
end