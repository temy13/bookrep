namespace :book_add_info do
  desc "add subtitle & google_categories to Books"
  task :book => :environment do
    offset = rand(Book.count)
    #@books = Book.where(subtitle: nil).and(Book.where(google_categories: nil)).and(Book.where(google_description: nil)).offset()
    @books = Book.where(google_description: nil).offset(offset).limit(25)
    @books.each{|book|
      begin
        uri = Addressable::URI.parse("https://www.googleapis.com/books/v1/volumes?q=id:" + book.google_books_id.to_s)
        #uri = Addressable::URI.parse("https://www.googleapis.com/books/v1/volumes/" + book.google_books_id.to_s)
        response = Net::HTTP.get_response(uri)
        result = JSON.parse(response.body)
        v = result["items"][0]["volumeInfo"]
        book.subtitle = v["subtitle"]
        book.google_categories = v["categories"].join(",") if v["categories"].present?
        book.google_description = v["description"]
        book.save
      rescue => e
        p e.message
      end
    }
  end
end
