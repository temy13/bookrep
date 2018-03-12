require 'rails_helper'

RSpec.describe "question/new", type: :view do
  it "visit page" do
    visit "/questions/new"
    #expect(assigns(:question)).to be_a_new Question
    page.has_css?('question-top')
    page.has_text?('質問してみましょう')
    #expect(page).to have_css('.target_class')
  end

  it "modal"

end
