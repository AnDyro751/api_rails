FactoryGirl.define do
  factory :answer do
    association :question , factory: :question
    description "MyString"
  end
end
