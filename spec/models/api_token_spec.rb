require 'rails_helper'

RSpec.describe ApiToken, type: :model do

	# Methods
  describe "on creation" do
  	it "generates a token" do
  		api_token = FactoryGirl.create(:api_token)
  		api_token.token.should_not be_nil
  	end
  end
end
