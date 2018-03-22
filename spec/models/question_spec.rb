# == Schema Information
#
# Table name: questions
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  content      :string           not null
#  is_anonymous :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  is_tweet     :boolean          default(FALSE)
#  image        :string
#  score        :integer          default(0)
#

require 'rails_helper'
require 'support/factory_bot'

describe Question do

  it 'neccesary content' do
     question = Question.new(
      user: create(:t_user)
    )
    expect(question).not_to be_valid
  end
  it 'neccesary user_id' do
    question = Question.new(
      content: "ontent",
    )
    expect(question).not_to be_valid
  end
  it 'validation ok' do
    question = Question.new(
      content: "ontent",
      user: create(:t_user)
    )
    expect(question).to be_valid
  end


  # it "name_or_anonymous (not length check)" do
  #   a = create(:question_u3) #not anonymous
  #   expect(a.name_or_anonymous).to eq build(:user_d1).name + "さん"
  #   a = create(:question_u1) #anonymous
  #   expect(a.name_or_anonymous).to eq "匿名"
  # end
  it "name_or_anonymous_post (not length check)" do
    a = create(:question_u3) #not anonymous
    expect(a.name_or_anonymous_post).to eq build(:user_d1).name + "さん"
    a = create(:question_u1) #anonymous
    expect(a.name_or_anonymous_post).to eq "匿名の投稿"
  end  #affiliate_url
  #user_icon
  #book_title
  #is_send_email
  #authors_txt

end
