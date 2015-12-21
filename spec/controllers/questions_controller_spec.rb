require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:question) { FactoryGirl.create(:question, user: user) }


  describe "GET #index" do
    before { get :index }

    it 'loads all questions' do
      questions = FactoryGirl.create_list(:question, 3)
      expect(assigns(:questions)).to eq questions
    end
    it 'renders "index" view' do
      expect(response).to render_template :index
    end

  end

  describe "GET #show" do
    before { get :show, id: question }

    it 'loads question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders "show" view' do
      expect(response).to render_template :show
    end

  end

  describe "GET #new" do

    before do
      login(user)
      get :new
    end


    it 'creates new question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders "new" view' do
      expect(response).to render_template :new
    end

  end

  describe "GET #edit" do
    before do
      login(user)
      get :edit, id: question
    end

    it 'selects question for edit' do
      expect(assigns(:question)).to eq question
    end

    it 'renders "edit" view' do
      expect(response).to render_template :edit
    end

  end

  describe "POST #create" do

    before { login(user) }

    context "Valid" do

      it 'saves new question to the DB' do
        expect { post :create, question: FactoryGirl.attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'redirects to "show" view' do
        post :create, question: FactoryGirl.attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end

    end

    context "Invalid" do

      it 'does not save new question to the DB' do
        expect { post :create, question: FactoryGirl.attributes_for(:invalid_question) }.not_to change(Question, :count)
      end

      it 'renders "new" view' do
        post :create, question: FactoryGirl.attributes_for(:invalid_question)
        expect(response).to render_template :new
      end

    end
  end

  describe "PATCH #update" do

    context 'Author updates his question and it is valid' do

      before do
        login(user)
        patch :update, id: question, question: { title: 'new title', body: 'new body' }
      end

      it 'changes question in the DB' do
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to "show" view' do
        expect(response).to redirect_to question
      end

    end

    context 'Author updates his question and it is invalid' do

      before do
        login(user)
        patch :update, id: question, question: { title: nil, body: nil }
      end

      it 'does not change question' do
        question.reload
        expect(question.title).to include('My', 'question')
        expect(question.body).to include('question', 'body')
      end

      it 'renders "edit" view' do
        expect(response).to render_template :edit
      end

    end

    context 'Non-author tries to updates question' do

      before do
        login(FactoryGirl.create(:user))
        patch :update, id: question, question: { title: 'new title', body: 'new body' }
      end

      it 'does not change question' do
        question.reload
        expect(question.title).to include('My', 'question')
        expect(question.body).to include('question', 'body')
      end

      it 'redirects to sign_in view' do
        expect(response).to redirect_to new_user_session_path
      end

    end

  end

  describe "DELETE #destroy" do

    context 'Author deletes his own question' do

      before do

        login(user)
        question

      end

      it 'deletes question from DB' do
        expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, id: question
        expect(response).to redirect_to questions_path
      end

    end

    context 'Non-author fails to delete someone elses question' do

      before { question }

      it 'Non-author tries to delete question from DB' do
        expect { delete :destroy, id: question }.not_to change(Question, :count)
      end

    end

  end

end
