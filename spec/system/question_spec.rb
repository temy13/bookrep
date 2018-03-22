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
    expect(page).to have_xpath("//img[contains(@src,'icon_home')]")
    expect(page).to have_xpath("//img[contains(@src,'blue_icon_post')]")
    expect(page).to have_xpath("//img[contains(@src,'icon_profile')]")
    expect(page).to have_content '質問する'

    click_button "post-by-account"
    page.has_css?("error")
    fill_in "question_content", with: "質問の中身だよ"
    click_button "post-by-account"
    q = Question.last
    expect(page).to have_content '回答する'
    expect(page).to have_content '質問が投稿されました'
    expect(page).to have_content q.content
    expect(page).to have_content q.user.name
    expect(q.is_anonymous).to eq false

    expect(page).to have_xpath("//img[contains(@src,'icon_home')]")
    expect(page).to have_xpath("//img[contains(@src,'icon_post')]")
    expect(page).to have_xpath("//img[contains(@src,'icon_profile')]")

  end

  it 'index questions' do
    login_as(@user, :scope => :user)
    visit "/questions"
    expect(page).to have_content '質問一覧'
    expect(page).to have_xpath("//img[contains(@src,'blue_icon_home')]")
    expect(page).to have_xpath("//img[contains(@src,'icon_post')]")
    expect(page).to have_xpath("//img[contains(@src,'icon_profile')]")

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
    expect(page).to have_css 'div.disabled'
    click_link "email-login"
    fill_in "input-email-field", with: "test0000e@ex.com"
    fill_in "input-password-field", with: "password"
    click_button "login-submit"
    expect(page).to have_content @question.content #質問一覧
  end

  it 'GET #new without login' do
    u = create(:e_user)
    visit "/questions/new"
    expect(page).to have_css 'div.disabled'
    click_link "email-login"
    fill_in "input-email-field", with: "test0000e@ex.com"
    fill_in "input-password-field", with: "password"
    click_button "login-submit"
    expect(page).to have_content @question.content #質問一覧
  end


  # it 'confirm modal & toggle', js: true do
  #   login_as(@user, :scope => :user)
  #   visit "/questions/new"
  #   click_link "show-modal-wq"
  #   #click_link "show-modal"
  #   #click_link "reply-arrow-img"
  # end

end
