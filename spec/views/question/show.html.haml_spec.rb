require 'rails_helper'
require 'support/factory_bot'


RSpec.describe "question/show", type: :view do
  let(:question) { create(:question) }
  it "visit page" do
    visit "/questions/" + question.id.to_s
    page.has_css?('question-top')
    page.has_text?(question.content)
    page.has_text?(question.user.name)
    #expect(assigns(:question)).to eq question
    #expect(page).to have_css('.target_class')
  end



  it "anonymous"
  it "answer anonymous"
  it "answer kaminari"

end
