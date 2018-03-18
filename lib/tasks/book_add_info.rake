namespace :book_add_info do
  desc "add subtitle & google_categories to Books"
  task :book => :environment do
    @books = Book.where(subtitle: nil).or(Book.where(google_categories: nil))
    @books.each{|book|
      p book
      p book.google_books_id
      begin
        uri = Addressable::URI.parse("https://www.googleapis.com/books/v1/volumes/" + book.google_books_id.to_s)
        p uri
        response = Net::HTTP.get_response(uri)
        result = JSON.parse(response.body)
        p result
        book.subtitle = result["volumeInfo"]["subtitle"],
        book.categories = result["volumeInfo"]["categories"].join(",") if result["volumeInfo"]["categories"].present?
        book.save
      rescue => e
        p e.message
      end
    }
  end
end
