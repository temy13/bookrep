require 'rails_helper'
require 'support/factory_bot'

describe ProfileController do
  let(:question){create (:question_u1)}
  let(:question2){create (:question_u2)}
  let(:user) { create(:user) }
  before do
    create(:question_nu, user: user)
    create(:question_anonymous, user: user)
    create(:answer_nu_nq, user: user, question: question)
    create(:answer_anonymous_nu_nq, user: user, question: question2)
    login_user user
  end
  describe 'GET #show' do
    before { get :show, params: { id: user.id }, session: {} }
    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end
    it 'assigns @user' do
      expect(assigns(:user)).to eq user
    end
    it 'renders the :show template' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #show in current_user' do
    let(:questions){user.questions}
    # let(:answer_questions){Question.where(id: [question.id,question2.id])}
    before do
      login_user user
    end

    before { get :show, params: { id: user.id }, session: {} }
    it 'assigns @questions' do
      expect(assigns(:questions)).to eq questions
    end
    it 'assigns @answers' do
      expect(assigns(:answer_questions).map{|item| item.id}).to eq [question.id, question2.id]
    end
    it "pagenation"
    it "pagenation"
  end

  describe 'GET #show not in current_user' do
    before do
      login_user create(:t_user)
    end
    let(:questions){user.questions.where(is_anonymous: false)}
    let(:answers){user.answers.where(is_anonymous: false)}
    # let(:answer_questions){Question.where(id: [question.id])}

    before { get :show, params: { id: user.id }, session: {} }
    it 'assigns @questions' do
      expect(assigns(:questions)).to eq questions
    end
    it 'assigns @answers' do
      expect(assigns(:answer_questions).map{|item| item.id}).to eq [question.id]
    end
    it "pagenation"
    it "pagenation"
  end


end
