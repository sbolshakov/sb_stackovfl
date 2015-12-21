require 'rails_helper'

feature 'Edit question', %q{

Author of the question should be able to edit it.

} do

  given!(:user) { FactoryGirl.create(:user) }
  given(:question) { FactoryGirl.create(:question, user: user) }

  scenario 'Owner edits his question' do

    login(user)

    visit question_path(question)

    click_on 'Edit Question'
    fill_in 'Question Title', with: 'Test Updated Question Title'
    fill_in 'Question Text', with: 'Test Updated Question Text'
    click_on 'Submit Question'

    expect(page).to have_content 'Your question was successfully updated!'
    expect(page).to have_content 'Test Updated Question Title'
    expect(page).to have_content 'Test Updated Question Text'

  end

  scenario 'Non-author tries to edit someone elses question' do

    login(FactoryGirl.create(:user))
    visit question_path(question)

    expect(page).not_to have_link 'Edit Question'

  end

  scenario 'Non-authenticated user tries to edit someone elses question' do

    visit question_path(question)

    expect(page).not_to have_link 'Edit Question'

  end

end