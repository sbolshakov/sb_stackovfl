FactoryGirl.define do
  factory :question do
    title "My Question"
    body "Question Body"
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end

end
