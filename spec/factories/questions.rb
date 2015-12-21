FactoryGirl.define do

  sequence :question_title do |n|

    "My question #{n}"

  end

  sequence :question_body do |n|

    "My question body #{n}"

  end

  factory :question do
    title { generate(:question_title) }
    body { generate(:question_body) }
    user
  end

  trait :with_answers do

    transient do
      number_of_answers 3
    end

    after :create do |question, evaluator|
      FactoryGirl.create_list :answer, evaluator.number_of_answers, question: question
    end

  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
    user nil
  end

end
