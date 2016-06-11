FactoryGirl.define do
  factory :user do
		sequence(:email){|n| "email#{n}#{rand(10000).to_s}@email.com"}
		password "123456"
		password_confirmation "123456"
		app
		after(:create) do |user|
			user.confirm!
		end
  end
  factory :user_with_identity, parent: :user do
  	identity
  end
end
