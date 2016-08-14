FactoryGirl.define do
  factory :client do
		sequence(:email){|n| "email#{n}#{rand(10000).to_s}@email.com"}
		password "123456"
		password_confirmation "123456"
		registration_token
		after(:create) do |client|
			client.skip_confirmation!
			client.registration_token.status = "used"
			client.save!
		end
  end

  factory :client_admin, parent: :client do
  	after(:create) do |client|
			client.role = "admin"
			client.save!
		end
  end
end
