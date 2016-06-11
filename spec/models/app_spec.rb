require 'rails_helper'

RSpec.describe App, type: :model do
  it "should belong to enterprise" do
  	expect(App.relations["enterprise"].macro == :belongs_to).to be true
  end
  it "should have many users" do
  	expect(App.relations["users"].macro == :has_many).to be true
  end
  it {should validate_presence_of(:enterprise)}
end
