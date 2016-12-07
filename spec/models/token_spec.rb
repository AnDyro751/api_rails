require 'rails_helper'

RSpec.describe Token, type: :model do

  it "should return valid when is not expired" do
    token = FactoryGirl.create(:token,expires_at: DateTime.now + 1.minute)
    expect(token.is_valid?).to eq(true)
  end

  it "should return invalid when is expired" do
    token = FactoryGirl.create(:token,expires_at: DateTime.now - 1.day)
    expect(token.is_valid?).to eq(false)
  end

end
