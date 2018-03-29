class AnswerBotWorker include Sidekiq::Worker

  def get_book(q)
    q = q.gsub(/\s/, "").gsub(" ", "")
    uri = Addressable::URI.parse("https://www.googleapis.com/books/v1/volumes?q=#{q}&country=JP&maxResults=40&orderBy=relevance")
    begin
      response = Net::HTTP.get_response(uri)
      result = JSON.parse(response.body)
      book_result = result["items"]
        .select{|item| item.has_key?("volumeInfo") &&  item["volumeInfo"].has_key?("title")}
        .take(1)
        .map{|item|
          {
            title: item["volumeInfo"]["title"],
            subtitle: item["volumeInfo"]["subtitle"],
            authors: item["volumeInfo"]["authors"],
            categories: item["volumeInfo"]["categories"],
            google_books_id: item["id"],
            info: item["volumeInfo"]["industryIdentifiers"]
          }
        }
      @results = Book.auto_complete_map(book_result)

      return @results.first
    rescue => e
      p e.message
    end
    nil
  end


  def perform(q_id)
    question = Question.find(q_id)
    book = get_book(question.content)
    p book
  end

end
