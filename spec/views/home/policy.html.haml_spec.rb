require 'rails_helper'

RSpec.describe "home/policy", type: :view do
  it "visit page" do
    visit "/home/policy"
    page.has_text?('プライバシーポリシー')
    #expect(page).to have_css('.target_class')
  end
end
