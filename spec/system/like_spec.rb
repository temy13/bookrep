require 'rails_helper'
require 'support/factory_bot'

RSpec.describe 'Likes', type: :system do
  before(:each) do
    @user = create(:user)
    @question = Question.create!(is_anonymous: true, user: @user, content: "中身コンテンツ")
    @answer = create(:answer_u2, question: @question)
  end

  it 'create like & destroy like' do
    login_as(@user, :scope => :user)
    visit "/questions/" + @question.id.to_s

    expect(page).to have_css 'i.fa.fa-heart-o.like'
    expect(page).not_to have_css 'i.fa.fa-heart.like'
    expect(find("#answer-like-#{@answer.id}-submit")).to have_content "0"
    click_button "answer-like-#{@answer.id}-submit"

    expect(page).not_to have_css 'i.fa.fa-heart-o.like'
    expect(page).to have_css 'i.fa.fa-heart.like'
    expect(find("#answer-like-#{@answer.id}-submit")).to have_content "1"
    click_button "answer-like-#{@answer.id}-submit"

    expect(page).to have_css 'i.fa.fa-heart-o.like'
    expect(page).not_to have_css 'i.fa.fa-heart.like'
    expect(find("#answer-like-#{@answer.id}-submit")).to have_content "0"
    click_button "answer-like-#{@answer.id}-submit"


  end


end
