# == Schema Information
#
# Table name: answers
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  question_id  :integer
#  content      :string           not null
#  book_id      :integer
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  is_tweet     :boolean          default(FALSE)
#  is_anonymous :boolean          default(FALSE)
#  score        :integer          default(0)
#

require 'rails_helper'
require 'support/factory_bot'

describe Answer do

  it 'neccesary user_id' do
    answer = Answer.new(
      title: "title",
      content: "ontent",
      question: create(:question)
    )
    expect(answer).not_to be_valid
  end
  it 'neccesary title' do
    answer = Answer.new(
      content: "ontent",
      user: create(:t_user),
      question: create(:question)
    )
    expect(answer).not_to be_valid
  end
  it 'neccesary content' do
    answer = Answer.new(
      title: "title",
      question: create(:question),
      user: create(:t_user)
    )
    expect(answer).not_to be_valid
  end
  it 'neccesary question_id' do
    answer = Answer.new(
      title: "title",
      content: "ontent",
      user: create(:t_user)
    )
    expect(answer).not_to be_valid
  end
  it 'validation ok' do
    answer = Answer.new(
      title: "title",
      content: "ontent",
      question: create(:question),
      user: create(:t_user)
    )
    expect(answer).to be_valid
  end


  #it "book_image_url"
  it "like_count" do
    u = create(:e_user)
    a = create(:answer_tu_q1)
    l = build(:like_true)
    l.answer = a
    l.user = u
    l.save
    l = build(:like_false_u1)
    l.answer = a
    l.save
    expect(a.like_count).to eq 1
    l = build(:like_true)
    l.answer = a
    l.user = u
    expect { l.save!(validate: false) }.to raise_error( ActiveRecord::RecordNotUnique )
  end
  # it "name_or_anonymous (not length check)" do
  #   a = create(:answer_tu_q1)
  #   expect(a.name_or_anonymous).to eq build(:t_user).name + "さん"
  #   a = create(:answer_anonymous_eu_q3)
  #   expect(a.name_or_anonymous).to eq "匿名"
  # end
  it "name_or_anonymous_post (not length check)" do
    a = create(:answer_tu_q1)
    expect(a.name_or_anonymous_post).to eq build(:t_user).name + "さん"
    a = create(:answer_anonymous_eu_q3)
    expect(a.name_or_anonymous_post).to eq "匿名の投稿"
  end

  it "affiliate_url" do
    associate_id = ENV["AMAZON_ASSOCIATE_ID"]
    a = create(:answer_tu_q1)
    url = a.affiliate_url(0)
    expect(url).to eq "https://www.amazon.co.jp/gp/search?ie=UTF8&tag=" + associate_id + "&index=books&keywords=" + a.title
    url = a.affiliate_url(1)
    expect(url).to eq "https://www.amazon.co.jp/gp/search?ie=UTF8&tag=" + associate_id + "&index=books&keywords=" + a.title
    book = Book.new(
      isbn10: "012345678",
      rakuten_affiliate_url: "https://rakuten.com"
    )
    a.book = book
    url = a.affiliate_url(0)
    expect(url).to eq "https://www.amazon.co.jp/gp/product/" + "012345678" + "/ref=as_li_tl?ie=UTF8&creativeASIN=" + "012345678" + "&tag=" + associate_id
    url = a.affiliate_url(1)
    expect(url).to eq "https://rakuten.com"
  end
  #affiliate_url
  #user_icon
  #book_title
  #is_send_email
  #authors_txt

end
