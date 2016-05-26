FactoryGirl.define do
  factory :client do
		sequence(:email){|n| "email#{n}#{rand(10000).to_s}@email.com"}
		password "12345678"
		password_confirmation "12345678"
		after(:create) do |client|
			client.confirm!
		end
  end

  factory :client_admin, parent: :client do
  	after(:create) do |client|
			client.role = "admin"
			client.save!
		end
  end
end
