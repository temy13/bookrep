require 'rails_helper'
require 'support/factory_bot'

describe AnswersController do
  let(:user) {create(:user) }
  let(:question) {create(:question_u1) }


  describe 'POST #create' do
    before do
      login_user user
    end
   let(:answer_attributes) {
     {:title => "title", :content => "content", :user_id => user.id, :question_id => question.id}#attributes_for(:answer)
   }
   it 'saves new answer' do
     expect do
       post :create, params: { answer: answer_attributes }, session: {}
     end.to change(Answer, :count).by(1)
   end
   it 'saves new answer with anonymous' do
     expect do
       post :create, params: { answer: answer_attributes, anonymous: "匿名で投稿する" }, session: {}
     end.to change(Answer, :count).by(1)
     answer = Answer.last
     expect(answer.is_anonymous).to eq true
   end
   it 'saves new answer with anonymous' do
     expect do
       post :create, params: { answer: answer_attributes, submit_type: "anonymous" }, session: {}
     end.to change(Answer, :count).by(1)
     answer = Answer.last
     expect(answer.is_anonymous).to eq true
   end
   it 'redirects the :create template' do
     post :create, params: { answer: answer_attributes }, session: {}
     answer = Answer.last
     expect(response).to redirect_to(question_path(answer.question.id))
   end
 end


end
