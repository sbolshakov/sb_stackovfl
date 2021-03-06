require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { FactoryGirl.create(:question) }

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
    before { get :new }

    it 'creates new question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders "new" view' do
      expect(response).to render_template :new
    end

  end

  describe "GET #edit" do
    before { get :edit, id: question }

    it 'selects question for edit' do
      expect(assigns(:question)).to eq question
    end

    it 'renders "edit" view' do
      expect(response).to render_template :edit
    end

  end

  describe "POST #create" do
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

    context 'valid' do

      before { patch :update, id: question, question: { title: 'new title', body: 'new body' } }

      it 'changes question in the DB' do
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to "show" view' do
        expect(response).to redirect_to question
      end

    end

    context 'invalid' do

      before { patch :update, id: question, question: { title: nil, body: nil } }

      it 'does not change question' do
        question.reload
        expect(question.title).to eq "My Question"
        expect(question.body).to eq "Question Body"
      end

      it 'renders "edit" view' do
        expect(response).to render_template :edit
      end

    end

  end

  describe "DELETE #destroy" do
    before { question }

    it 'deletes question from DB' do
      expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end


end
