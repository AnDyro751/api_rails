require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of(:email) }
  it { should_not allow_value("anhe@jans").for(:email) }
  it { should allow_value("anhe@jans.com").for(:email) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:uid) }


end
