FactoryGirl.define do
	factory :app do
		sequence(:name){|n| "name#{n}#{rand(10000).to_s}"}
		sequence(:domain){|n| "name#{n}#{rand(10000).to_s}.com"}
		callback "/callback"
		enterprise
	end

	factory :app_admin, parent: :app do
		after(:create) do |app|
			app.api_token.role = "admin"
			app.save!
		end
	end
end