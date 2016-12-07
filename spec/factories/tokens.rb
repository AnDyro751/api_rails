FactoryGirl.define do
  factory :token do
    expires_at "2016-11-26 17:11:06"
    association :user , factory: :user
  end
end
