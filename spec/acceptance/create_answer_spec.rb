require 'rails_helper'

feature 'Create answer to question', %q{

Any authenticated user can provide his answer for question.

} do

  given!(:user) { FactoryGirl.create(:user) }

  scenario 'Authenticated user creates answer to question' do

    login(user)

    FactoryGirl.create(:question)
    visit questions_path
    click_on 'Answer Question'
    fill_in 'Answer', with: 'My clever answer text'
    click_on 'Submit Answer'

    expect(page).to have_content 'Your answer was successfully submitted!'
    expect(page).to have_content 'My clever answer text'


  end

  scenario 'Non-authenticated user tries to answer question' do

    FactoryGirl.create(:question)
    visit questions_path
    click_on 'Answer Question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path

  end


end