require 'rails_helper'

feature 'Delete question', %q{

Author can delete his own question. Non-author and/or non-authenticated use cannot delete question

} do

  given!(:user) { FactoryGirl.create(:user) }
  given(:question) { FactoryGirl.create(:question, user: user) }

  scenario 'Author can delete his own question' do

    login(user)
    visit question_path(question)

    click_on 'Delete'

    expect(current_path).to eq questions_path
    expect(page).to_not have_content question.title

  end

  scenario 'Non-author tries to delete someone elses question' do

    login(FactoryGirl.create(:user))
    visit question_path(question)

    expect(page).not_to have_link 'Delete'

  end

  scenario 'Non-authenticated user tries to delete someone elses question' do

    visit question_path(question)

    expect(page).not_to have_link 'Delete'

  end


end