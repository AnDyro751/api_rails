FactoryGirl.define do
  factory :token do
    token "MyString"
    user nil
    expires_at "2016-12-06 17:09:57"
  end
end
