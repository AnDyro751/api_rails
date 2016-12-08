FactoryGirl.define do
  factory :my_poll do
    association :user , factory: :user
    description "MyText jnajs as"
    expires_at "2016-12-07 21:25:05"
    title "MyString ajnsa"
  end
end
