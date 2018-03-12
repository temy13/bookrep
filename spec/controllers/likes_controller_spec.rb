require 'rails_helper'
require 'support/factory_bot'

describe LikesController do
  let(:user) { create(:user) }
  let(:answer) { create(:answer_anonymous_tu_q2) }
  let(:like_attributes) {
    {:answer_id => answer.id, :user_id => user.id}#attributes_for(:question)
  }
  describe 'POST #create' do
    it 'not exist' do
      expect do
        post :create, params: like_attributes, xhr: true
      end.to change(Like, :count).by(1)
      expect(Like.last.like).to eq true
    end

    it 'exist' do
      create(:like_false, user_id: user.id, answer_id: answer.id)
      expect(Like.where(user_id: user.id, answer_id: answer.id, like: false).size).to eq 1
      expect(Like.where(user_id: user.id, answer_id: answer.id, like: true).size).to eq 0
      expect do
        post :create, params: like_attributes, xhr: true
      end.to change(Like, :count).by(0)
      expect(Like.where(user_id: user.id, answer_id: answer.id, like: false).size).to eq 0
      expect(Like.where(user_id: user.id, answer_id: answer.id, like: true).size).to eq 1
    end

  end
  describe 'POST #destroy' do
    it 'not exist' do
      expect do
        post :destroy, params: like_attributes, xhr: true
      end.to change(Like, :count).by(0)
      # expect(Like.last.like).to eq true
    end

    it 'exist' do
      create(:like_true, user_id: user.id, answer_id: answer.id)
      expect(Like.where(user_id: user.id, answer_id: answer.id, like: true).size).to eq 1
      expect(Like.where(user_id: user.id, answer_id: answer.id, like: false).size).to eq 0
      expect do
        post :destroy, params: like_attributes, xhr: true
      end.to change(Like, :count).by(0)
      expect(Like.where(user_id: user.id, answer_id: answer.id, like: false).size).to eq 1
      expect(Like.where(user_id: user.id, answer_id: answer.id, like: true).size).to eq 0
    end
  end

end
