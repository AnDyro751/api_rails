FactoryGirl.define do
  factory :question do
    association :my_poll , factory: :my_poll
    description "¿Cual es tu navegador favorito ?"
  end
end
