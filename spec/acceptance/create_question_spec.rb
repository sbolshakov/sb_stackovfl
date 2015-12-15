require 'rails_helper'

feature 'Create question', %q{

In order to get answers from other users, I, as an authenticated user,
shall be able to create new question.

} do

  given!(:user) { FactoryGirl.create(:user) }

  scenario 'Authenticated user creates question' do

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in  'Password', with: '12345678'
    click_on 'Log in'

    visit questions_path
    click_on 'Ask Question'

    fill_in 'Question Title', with: 'Test Question Title'
    fill_in 'Question Text', with: 'Test Question Text'
    click_on 'Submit Question'

    expect(page).to have_content 'Your question was successfully created!'
    expect(page).to have_content 'Test Question Title'
    expect(page).to have_content 'Test Question Text'

  end

  scenario 'Non-authenticated user tries to create question' do

    visit questions_path
    click_on 'Ask Question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path

  end

end