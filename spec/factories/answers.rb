FactoryGirl.define do

  sequence :answer_body do |n|

    "My clever answer body #{n}"

  end

  factory :answer do
    body { generate(:answer_body) }
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    user nil
  end


end
