require 'rails_helper'
require 'support/factory_bot'
# require 'support/capybara_modules'

RSpec.describe 'User', type: :system do
  before(:each) do
    @user = create(:e_user)
    @t_user = create(:t_user)
  end

  it "/user/edit (e_user)" do
    login_as(@user, :scope => :user)
    visit "/profile/" + @user.id.to_s
    click_link "users-edit-link"
    expect(page).to have_content "設定"
    fill_in "user[name]", with: "テストパイセン"
    fill_in "user[current_password]", with: "password"
    click_button "user-update-button"
    expect(page).to have_content "テストパイセン"
    # expect(page).to have_content @user.name
    expect(page).to have_content "アカウント情報を変更しました"
  end

  it "/user/edit (e_user update password)" do
    login_as(@user, :scope => :user)
    visit "/profile/" + @user.id.to_s
    click_link "users-edit-link"
    expect(page).to have_content "設定"
    fill_in "user[current_password]", with: "password"
    fill_in "user[password]", with: "password2"
    click_button "user-update-button"
    expect(page).to have_content "アカウント情報を変更しました"

    click_link "users-edit-link"
    expect(page).to have_content "設定"
    fill_in "user[name]", with: "テストパイセン2"
    fill_in "user[current_password]", with: "password2"
    click_button "user-update-button"
    expect(page).to have_content "テストパイセン2"
    # expect(page).to have_content @user.name
    expect(page).to have_content "アカウント情報を変更しました"
  end

  it "/user/edit (t_user, update without password)" do
    login_as(@t_user, :scope => :user)
    visit "/profile/" + @t_user.id.to_s
    click_link "users-edit-link"
    expect(page).to have_content "設定"
    fill_in "user[name]", with: "テストパイセン"
    click_button "user-update-button"
    expect(page).to have_content "テストパイセン"
    # expect(page).to have_content @user.name
    expect(page).to have_content "アカウント情報を変更しました"
  end

end
