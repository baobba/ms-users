FactoryGirl.define do
	uattr_hash = {"attr1" => ["value1", "value2" => {"sattr1" => "svalue1"}], "attr2" => 10}
  factory :user do
		sequence(:email){|n| "email#{n}#{rand(10000).to_s}@email.com"}
		password "123456"
		password_confirmation "123456"
		app
		uattr uattr_hash
		after(:create) do |user|
			user.skip_confirmation!
		end
  end
end
