require 'rails_helper'
require 'support/factory_bot'
# require 'support/capybara_modules'

RSpec.describe 'Login', type: :system do
  before(:each) do
    @user = create(:user)
    @question = Question.create!(is_anonymous: true, user: @user, content: "中身コンテンツ")
  end

  it "login at /users/login by email" do
    visit "/users/login"
    expect(page).to have_xpath("//img[contains(@src,'TitleLogo_2_Blue')]")
    fill_in "user[email]", with: @user.email
    fill_in "user[password]", with: @user.password
    click_button "login-submit"
    expect(page).to have_content 'ログインしました'
    expect(page).to have_content '「ブクリプ」へようこそ'
    expect(page).to have_content @user.name
  end

  it "login at /questions/show by email"

  it "sign up at / by email" do
    visit "/"
    fill_in "user-login-email-1", with: @user.email
    fill_in "user-login-password-1", with: @user.password
    click_button "login-submit"
    expect(page).to have_content "そのメールアドレスはすでに登録されています"
    expect(page).to have_content "意外な一冊に出会える"

    fill_in "user-login-email-1", with: "new-email@example.com"
    fill_in "user-login-password-1", with: "パスワードだってばよ"
    click_button "login-submit"
    expect(page).to have_content 'アカウント登録が完了しました'
    expect(page).to have_content '「ブクリプ」へようこそ'
  end

end
