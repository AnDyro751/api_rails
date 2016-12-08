require 'rails_helper'

RSpec.describe MyPoll, type: :model do
  it { should validate_presence_of(:title) }
  it { should_not allow_value("").for(:title) }

  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:expires_at) }
  it { should belong_to(:user) }

  it "should return valid when is not expired" do
    my_poll = FactoryGirl.create(:my_poll,expires_at: DateTime.now + 1.minute)
    expect(my_poll.is_valid?).to eq(true)
  end

  it "should return invalid when is expired" do
    my_poll = FactoryGirl.create(:my_poll,expires_at: DateTime.now - 1.day)
    expect(my_poll.is_valid?).to eq(false)
  end

end
