require 'rails_helper'
require 'support/factory_bot'

describe QuestionsController do
   let(:user) { create(:user) }

   describe 'GET #index' do

    let(:questions) {
      t_user = create(:t_user)
      create_list(:question, 2, user: t_user)
    }
    before { get :index, params: {}, session: {} }
    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end
    it 'assigns @questions' do
      expect(assigns(:questions)).to match_array questions
    end
    it 'renders the :index template' do
      expect(response).to render_template :index
    end

    it "kaminari"

  end

  describe 'GET #show' do
    before do
      login_user user
    end
    let(:question) {create(:question_u1_has_answers)}
    let(:answer) {build(:answer, user: user)}
    let(:answers) {question.answers}
    before { get :show, params: { id: question.id }, session: {} }
    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end
    it 'assigns @question' do
      expect(assigns(:question)).to eq question
    end
    it 'assigns @answers' do
      expect(assigns(:answers)).to eq answers
    end
    it 'assigns new @answer' do
      expect(assigns(:answer)).to be_a_new Answer
    end
    it 'renders the :show template' do
      expect(response).to render_template :show
    end

    it "kaminari"
  end

  # describe 'GET #new with not login' do
  #   before { get :new, params: {}, session: {} }
  #   it 'has a 302 status code' do
  #     expect(response).to have_http_status(302)
  #   end
  #   it 'renders the :new template' do
  #     expect(response).to redirect_to("/users/login")
  #   end
  # end

  describe 'GET #new' do
     before do
       login_user user
     end
     #let(:question) {build(:question)}
     before { get :new, params: {}, session: {} }
     it 'has a 200 status code' do
       expect(response).to have_http_status(:ok)
     end
     it 'assigns new @question' do
       expect(assigns(:question)).to be_a_new Question
     end
     it 'renders the :new template' do
       expect(response).to render_template :new
     end
   end

   describe 'POST #create' do
     before do
       login_user user
     end
    let(:question_attributes) {
      {:content => "content", :user_id => user.id}#attributes_for(:question)
    }
    it 'saves new question' do
      expect do
        post :create, params: { question: question_attributes }, session: {}
      end.to change(Question, :count).by(1)
    end
    it 'saves new question with anonymous' do
      expect do
        post :create, params: { question: question_attributes, anonymous: "匿名で投稿する" }, session: {}
      end.to change(Question, :count).by(1)
      question = Question.last
      expect(question.is_anonymous).to eq true
    end
    it 'saves new question with anonymous' do
      expect do
        post :create, params: { question: question_attributes, submit_type: "anonymous" }, session: {}
      end.to change(Question, :count).by(1)
      question = Question.last
      expect(question.is_anonymous).to eq true
    end
    it 'redirects the :create template' do
      post :create, params: { question: question_attributes }, session: {}
      question = Question.last
      expect(response).to redirect_to(question_path(question))
    end
  end

  describe "POST ajax #reply_options" do
    it 'with no query'
    it 'with query'
  end


end
