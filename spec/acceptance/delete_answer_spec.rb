require 'rails_helper'

feature 'Delete answer', %q{

Author can delete his own answer. Non-author and/or non-authenticated use cannot delete somone elses answer

} do

  given!(:user) { FactoryGirl.create(:user) }
  given!(:question) { FactoryGirl.create( :question, user: user ) }
  given!(:answer) { FactoryGirl.create( :answer, question: question, user: user)}

  scenario 'Author can delete his own answer' do

    login(user)
    visit question_path(question)
    click_on 'Delete Answer'

    expect(current_path).to eq question_path(question)
    expect(page).to_not have_content answer.body

  end

  scenario 'Non-author tries to delete someone elses answer' do

    login(FactoryGirl.create(:user))
    visit question_path(question)

    expect(page).not_to have_link 'Delete Answer'

  end

  scenario 'Non-authenticated user tries to delete someone elses answer' do

    visit question_path(question)

    expect(page).not_to have_link 'Delete Answer'

  end


end