FactoryGirl.define do
	factory :enterprise do
		sequence(:name){|n| "Nome da empresa #{n} #{rand(10000).to_s}"}
		sequence(:domain){|n| "http://www.enterprise#{n}.com/"}
		client
	end
end