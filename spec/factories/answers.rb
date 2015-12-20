FactoryGirl.define do
  factory :answer do
    body "Answer Body"
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
  end

end
