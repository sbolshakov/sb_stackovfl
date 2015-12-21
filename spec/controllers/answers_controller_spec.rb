require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:question) { FactoryGirl.create(:question, user: user) }
  let(:answer) { FactoryGirl.create(:answer, question: question, user: user) }

  describe "GET #new" do
    before do
      login(user)
      get :new, question_id: question
    end

    it 'creates new question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders "new" view' do
      expect(response).to render_template :new
    end

  end

  describe "POST #create" do

    before { login(user) }

    context 'valid' do

      it 'saves new answer to the DB and link it to the question' do
        expect {
          post :create, question_id: question, answer: FactoryGirl.attributes_for(:answer), format: :js
        }.to change(question.answers, :count).by(1)
      end

      it "redirects to questions list" do
          post :create, question_id: question, answer: FactoryGirl.attributes_for(:answer), format: :js
          expect(response).to render_template :create
      end

    end

    context 'invalid' do

      it 'does not save new answer to the DB' do

        expect {
          post :create, question_id: question, answer: FactoryGirl.attributes_for(:invalid_answer), format: :js
        }.not_to change(Answer, :count)

      end

      it 'renders "new" view' do
        post :create, question_id: question, answer: FactoryGirl.attributes_for(:invalid_answer), format: :js
        expect(response).to render_template :new
      end

    end

  end

  describe "PATCH #update" do

    context 'Author updates his answer and it is valid' do

      before do
        login(user)
        patch :update, id: answer, answer: { body: 'new body' }
      end

      it 'changes question in the DB' do
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'redirects to question show view' do
        expect(response).to redirect_to question
      end

    end

    context 'Author updates his question and it is invalid' do

      before do
        login(user)
        patch :update, id: answer, answer: { body: nil }
      end

      it 'does not change question' do
        answer.reload
        expect(answer.body).to include('answer', 'body')
      end

      it 'renders "edit" view' do
        expect(response).to render_template :edit
      end

    end

    context 'Non-author tries to updates answer' do

      before do
        login(FactoryGirl.create(:user))
        patch :update, id: answer, answer: { body: 'new body' }
      end

      it 'does not change question' do
        answer.reload
        expect(answer.body).to include('answer', 'body')
      end

      it 'redirects to sign_in view' do
        expect(response).to redirect_to new_user_session_path
      end

    end

  end



  describe "DELETE #destroy" do
    before { login(user) }

    context 'Author deletes his own answer' do

      let!(:question) { FactoryGirl.create(:question, user: user) }
      let!(:answer) { FactoryGirl.create(:answer, question: question, user: user) }

      it 'deletes answer from DB' do
        expect { delete :destroy, id: answer, format: :js }.to change(Answer, :count).by(-1)
      end

      it 'redirects to question show view' do
        delete :destroy, id: answer, format: :js
        expect(response).to render_template 'answers/destroy'
      end

    end

    context 'Non-author fails to delete someone elses answer' do

      let!(:question) { FactoryGirl.create(:question, user: user) }
      let!(:answer) { FactoryGirl.create(:answer, question: question, user: user) }

      it 'Non-author tries to delete answer from DB' do
        expect { delete :destroy, id: answer, format: :js }.not_to change(Question, :count)
      end

    end

  end

end
