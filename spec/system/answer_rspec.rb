require 'rails_helper'
require 'support/factory_bot'

RSpec.describe 'Answers', type: :system do
  before(:each) do
    @user = create(:user)
    @t_user = create(:t_user)
    @question = Question.create!(is_anonymous: true, user: @user, content: "中身コンテンツ")
    @answer = Answer.create!(is_anonymous: false, user: @t_user, content: "かいつ", title: "タイトル", question: @question)
  end

  it 'new answer' do
    login_as(@user, :scope => :user)
    visit "/questions/" + @question.id.to_s
    click_button "post-by-account"
    page.has_css?("error")
    fill_in "answer_content", with: "質問の中身だよ"
    click_button "post-by-account"
    page.has_css?("error")
    fill_in "title_dummy", with: "タイトルだよ3"
    click_button "post-by-account"

    a = Answer.last
    expect(page).to have_content '回答が投稿されました'
    expect(page).to have_content a.content
    expect(page).to have_content a.user.name
    expect(a.title).to eq "タイトルだよ3"
    expect(a.is_anonymous).to eq false
  end

  it 'new anonymous answer' do
    login_as(@user, :scope => :user)
    visit "/questions/" + @question.id.to_s
    click_button "post-by-account"
    page.has_css?("error")
    fill_in "answer_content", with: "質問の中身だよ"
    click_button "post-by-account"
    page.has_css?("error")
    fill_in "title_dummy", with: "タイトルだよ34"
    click_button "post-by-anonymous"

    a = Answer.last
    expect(page).to have_content '回答が投稿されました'
    expect(page).to have_content a.content
    expect(page).to have_content "匿名の投稿"
    expect(a.title).to eq "タイトルだよ34"
    expect(a.is_anonymous).to eq true
  end




end
