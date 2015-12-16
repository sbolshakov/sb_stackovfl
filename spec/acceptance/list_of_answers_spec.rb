require 'rails_helper'

feature 'List of answers to questions for any user', %q{
        Any user can see list of answers submitted to the exiting questions
} do

  scenario 'Any user can see list of answers' do

    questions = FactoryGirl.create_list(:question, 3, :with_answers, number_of_answers: 4)
    visit questions_path
    questions.each do |question|

      expect(page).to have_content(question.title)
      expect(page).to have_content(question.body)

      question.answers.each do |answer|

        expect(page).to have_content(answer.body)

      end

    end

  end

end

