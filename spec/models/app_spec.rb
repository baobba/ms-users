require 'rails_helper'

RSpec.describe App, type: :model do
  it { should have_one(:enterprise) }
end
