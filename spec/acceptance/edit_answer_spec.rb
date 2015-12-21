require 'rails_helper'

feature 'Edit answer', %q{

Author can edit his own answer. Non-author and/or non-authenticated use cannot edit somone elses answer

} do

  given!(:user) { FactoryGirl.create(:user) }
  given!(:question) { FactoryGirl.create( :question, user: user ) }
  given!(:answer) { FactoryGirl.create( :answer, question: question, user: user)}

  scenario 'Author can edit his own answer' do

    login(user)
    visit question_path(question)
    click_on 'Edit Answer'

    fill_in 'Answer', with: 'My updated clever answer text'
    click_on 'Submit Answer'

    expect(page).to have_content 'Your answer was successfully updated!'
    expect(page).to have_content 'My updated clever answer text'


  end

  scenario 'Non-author tries to edit someone elses answer' do

    login(FactoryGirl.create(:user))
    visit question_path(question)

    expect(page).not_to have_link 'Edit Answer'

  end

  scenario 'Non-authenticated user tries to edit someone elses answer' do

    visit question_path(question)

    expect(page).not_to have_link 'Edit Answer'

  end


end