require 'rails_helper'

feature 'Create answer to question', %q{

Any authenticated user can provide his answer for question.

} do

  given!(:user) { FactoryGirl.create(:user) }
  given(:question) { FactoryGirl.create(:question) }

  scenario 'Authenticated user creates answer to question', js: true do

    login(user)
    visit question_path(question)
    fill_in 'Answer', with: 'My clever answer text'
    click_on 'Submit Answer'

    # expect(page).to have_content 'Your answer was successfully submitted!'
    expect(page).to have_content 'My clever answer text'


  end

  scenario 'Non-authenticated user tries to answer question' do

    visit question_path(question)
    # click_on 'Answer Question'

    expect(page).to_not have_content 'Submit Answer'
    # expect(current_path).to eq new_user_session_path

  end


end