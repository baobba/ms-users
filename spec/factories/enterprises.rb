FactoryGirl.define do
	factory :enterprise do
		sequence(:name){|n| "Nome da empresa #{n} #{rand(10000).to_s}"}
	end
end