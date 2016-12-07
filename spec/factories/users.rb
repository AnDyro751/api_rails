FactoryGirl.define do
  factory :user do
    email "angel@gmail.com"
    name "Angel Mendez"
    provider "Facebook"
    uid "MyProvider123"
  end
end
