require 'rails_helper'
require 'support/factory_bot'

RSpec.describe 'Questions', type: :system do
  before(:each) do
    @user = create(:user)
    @t_user = create(:t_user)
    @question = Question.create!(is_anonymous: true, user: @user, content: "中身コンテンツ")
  end

  it 'new question' do
    login_as(@user, :scope => :user)
    visit "/questions/new"
    click_button "post-by-account"
    page.has_css?("error")
    fill_in "question_content", with: "質問の中身だよ"
    click_button "post-by-account"
    q = Question.last
    expect(page).to have_content '質問が投稿されました'
    expect(page).to have_content q.content
    expect(page).to have_content q.user.name
    expect(q.is_anonymous).to eq false
  end

  it 'new anonymous question' do
    login_as(@user, :scope => :user)
    visit "/questions/new"
    click_button "post-by-anonymous"
    page.has_css?("error")
    fill_in "question_content", with: "質問の中身だよ"
    click_button "post-by-anonymous"
    q = Question.last
    expect(page).to have_content '質問が投稿されました'
    expect(page).to have_content q.content
    expect(page).to have_content '匿名の投稿'
    expect(q.is_anonymous).to eq true
  end

  it 'new question with twitter-user' do
    login_as(@t_user, :scope => :user)
    visit "/questions/new"
    click_button "post-by-account"
    page.has_css?("error")
    fill_in "question_content", with: "質問の中身だよ"
    click_button "post-by-account"
    q = Question.last
    expect(page).to have_content '質問が投稿されました'
    expect(page).to have_content '通知'
    expect(page).to have_content q.content
    expect(page).to have_content q.user.name
    expect(q.is_anonymous).to eq false
  end

  it 'new anonymous question with twitter-user' do
    login_as(@t_user, :scope => :user)
    visit "/questions/new"
    click_button "post-by-anonymous"
    page.has_css?("error")
    fill_in "question_content", with: "質問の中身だよ"
    click_button "post-by-anonymous"
    q = Question.last
    expect(page).to have_content '質問が投稿されました'
    expect(page).to have_content '通知'
    expect(page).to have_content q.content
    expect(page).to have_content '匿名の投稿'
    expect(q.is_anonymous).to eq true
  end

  it 'GET #show without login' do
    create(:e_user)
    visit "/questions/" + @question.id.to_s
    page.has_css?("disable")
    click_link "email-login"
    fill_in "input-email-field", with: "test0000e@ex.com"
    fill_in "input-password-field", with: "password"
    page.has_text?(@question.content)

  end


  # it 'confirm modal & toggle', js: true do
  #   login_as(@user, :scope => :user)
  #   visit "/questions/new"
  #   click_link "show-modal-wq"
  #   #click_link "show-modal"
  #   #click_link "reply-arrow-img"
  # end

end
