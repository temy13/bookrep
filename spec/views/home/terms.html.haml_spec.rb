require 'rails_helper'

RSpec.describe "home/terms", type: :view do
  it "visit page" do
    visit "/home/terms"
    page.has_text?('利用規約')
    #expect(page).to have_css('.target_class')
  end
end
