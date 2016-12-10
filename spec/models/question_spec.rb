require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:my_poll) }
  it{ should validate_presence_of(:my_poll) }
  it{ should validate_presence_of(:description) }
  it{ should validate_length_of(:description).is_at_least(10) }
end
