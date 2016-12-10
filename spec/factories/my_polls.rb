FactoryGirl.define do
  factory :my_poll do
    association :user , factory: :sequence_user
    description "MyText jnajs as"
    expires_at "2016-12-07 21:25:05"
    title "MyString ajnsa"
    factory :poll_with_question do
      title "Poll with question"
      description "JNDHS whgeywgysqgwyqgwyqfwyqhhqw gwh qwh hq"
      questions { build_list :question , 2 }
    end
  end
end
