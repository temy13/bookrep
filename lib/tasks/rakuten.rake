namespace :rakuten do

  task :answer_book_urls => :environment do
    Answer.includes(:book).all.each do |a|
      book = a.book
      next if book.blank?
      next if book.isbn13.blank?
      next if book.rakuten_affiliate_url.present?
      r = RakutenWebService::Books::Book.search(isbn: book.isbn13).first
      next if r.blank?
      book.rakuten_affiliate_url = r.affiliate_url
      book.save
    end
  end

  task :all_books_urls => :environment do
    Book.all.each do |book|
      next if book.isbn13.blank?
      next if book.rakuten_affiliate_url.present?
      r = RakutenWebService::Books::Book.search(isbn: book.isbn13).first
      next if r.blank?
      book.rakuten_affiliate_url = r.affiliate_url
      book.save
      sleep(0.5)
      p book
    end
  end


end
