require 'rails_helper'

feature 'List of questions for any user', %q{
        Any user can see list of existing questions
} do

  scenario 'Any user can see list of existing questions' do

    questions = FactoryGirl.create_list(:question, 3)
    visit questions_path
    questions.each do |question|

      expect(page).to have_content(question.title)
      expect(page).to have_content(question.body)

    end

  end

end

