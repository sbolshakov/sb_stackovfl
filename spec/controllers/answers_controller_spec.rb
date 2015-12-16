require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { FactoryGirl.create(:question) }
  let(:answer) { FactoryGirl.create(:answer) }
  let(:user) { FactoryGirl.create(:user) }

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
          post :create, question_id: question, answer: FactoryGirl.attributes_for(:answer)
        }.to change(question.answers, :count).by(1)
      end

      it "redirects to questions list" do
          post :create, question_id: question, answer: FactoryGirl.attributes_for(:answer)
          expect(response).to redirect_to questions_path
      end

    end

    context 'invalid' do

      it 'does not save new answer to the DB' do

        expect {
          post :create, question_id: question, answer: FactoryGirl.attributes_for(:invalid_answer)
        }.not_to change(Answer, :count)

      end

      it 'renders "new" view' do
        post :create, question_id: question, answer: FactoryGirl.attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end

    end

  end

end
