FactoryGirl.define do
  factory :user do
    email "angel@gmail.com"
    name "Angel Mendez"
    provider "Facebook"
    uid "MyProvider123"
    factory :dummy_user do
      email "angelasaj@gmail.com"
      name "Angel Carmona"
      provider "Github"
      uid "MyProvider123"
    end
    factory :dummy_user_dup do
      email "aneaksmlasajajn@gmail.com"
      name "Angel xD"
      provider "Google"
      uid "MyProvider123"
    end
    factory :sequence_user do
      sequence(:email) { |n| "user#{n}@gasbga.com" }
      name "Angel Carmona"
      provider "Github"
      uid "MyProvider123"
    end
  end
end
