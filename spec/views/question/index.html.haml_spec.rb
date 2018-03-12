require 'rails_helper'

RSpec.describe "question/index", type: :view do
  it "visit page" do
    visit "/questions"
    page.has_css?('questions')
    #expect(page).to have_css('.target_class')
  end

  it "kaminari"

end
