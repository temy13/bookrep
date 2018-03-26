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

class Answer < ApplicationRecord
  include QAModule

  belongs_to :question
  belongs_to :user
  belongs_to :book, optional: true
  has_many :likes
  has_many :book_click_logs


  validates :title, presence: true
  validates :content, presence: true

  # def book
  #   @book = Book.find(self.book_id) if self.book_id.present? else nil
  #   @book
  # end

  def book_image_url
    return self.book_id ? self.book.image_url : "content_blank01"
  end

  def affiliate_url(answer_index = 0)
    #@book = Book.find(self.book_id) if self.book_id.present? else nil
    @book = self.book
    associate_id = ENV["AMAZON_ASSOCIATE_ID"]
    return "https://www.amazon.co.jp/gp/search?ie=UTF8&tag=" + associate_id + "&index=books&keywords=" + self.title if @book.blank?
    @book.affiliate_url(associate_id, answer_index)
  end


  def user_icon
    return self.user.icon unless self.is_anonymous
    path = "/assets/icons/" + rand(1..6).to_s
    path
  end

  def book_title
    title
    #return title.length < 20 ? title : title[0...20] + "..."
  end

  def is_send_email
    self.question.user.is_send_email
  end

  def authors_txt
    self.book.present? ? self.book.authors_txt : ""
  end

  def like_count
    Like.where(answer_id: self.id, like: true)
      .uniq{ |m| "#{m[:answer_id]}-#{m[:user_id]}" }
      .length
  end


end
