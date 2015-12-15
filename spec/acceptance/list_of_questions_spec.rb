require 'rails_helper'

feature 'List of questions for any user', %q{
        Any user can see list of existing questions
} do

  scenario 'Any user can see list of existing questions' do

    FactoryGirl.create_list(:question, 3)
    visit questions_path
    for n in 1..3
      expect(page).to have_content "My #{n} question"
      expect(page).to have_content "My #{n} question body"
    end



  end



end

