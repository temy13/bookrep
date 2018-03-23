# == Schema Information
#
# Table name: books
#
#  id                    :integer          not null, primary key
#  title                 :string
#  isbn10                :string
#  isbn13                :string
#  asin                  :string
#  google_books_id       :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  subtitle              :string
#  google_categories     :string
#  rakuten_affiliate_url :string
#

class Book < ApplicationRecord
  has_many :authors
  has_many :book_click_logs

  #mapの配列をもらい、mapを返す
  def self.auto_complete_map(arr)
    ids = arr.map{|m| m[:google_books_id]}
    @results = Book
      .includes(:authors)
      .where(google_books_id: ids)
      .to_a
    saved = @results.map{|r| r.google_books_id}
    new_authors = []
    arr.each do |m|
      next if saved.include?(m[:google_books_id])
      @book = self.new_book(m)
      next unless @book.save
      new_authors.concat(self.new_authors(@book, m))
      @results.push(@book)
    end
    Author.import new_authors if new_authors
    @results.map{|book|
      {
        id: book.id,
        title: book.title,
        subtitle: book.subtitle,
        authors: book.authors_txt,
        imgurl: book.image_url
      }
    }
  end

  def self.new_book(m)
    @book = Book.new(
      title: m[:title],
      subtitle: m[:subtitle],
      google_books_id: m[:google_books_id]
    )
    @book.google_categories = m[:categories].join(",") if m[:categories].present?
    Array(m[:info]).each do |item|
      if item["type"] == "ISBN_10"
        @book.isbn10 = item["identifier"]
      elsif item["type"] == "ISBN_13"
        @book.isbn13 = item["identifier"]
      end
    end
    @book
  end

  def self.new_authors(book, m)
    return [] unless m[:authors]
    authors = []
    m[:authors].each do |name|
      authors << Author.new(book_id: book.id, name: name)
    end
    authors
  end

  def affiliate_url(associate_id)
    code = self.asin || self.isbn10
    return "https://www.amazon.co.jp/gp/search?ie=UTF8&tag=" + associate_id + "&index=books&keywords=" + self.title if code.blank?
    #return self.rakuten_affiliate_url if self.rakuten_affiliate_url.present? #affiliate_idは0322でとったもので固定
    "https://www.amazon.co.jp/gp/product/" + code + "/ref=as_li_tl?ie=UTF8&creativeASIN=" + code + "&tag=" + associate_id
  end

  def image_url
    "http://books.google.com/books/content?id=" + self.google_books_id + "&printsec=frontcover&img=1&zoom=1&source=gbs_api"
  end

  def authors_txt
    self.authors
      .map{|item| item.name}
      .uniq
      .join(", ")
  end

end
