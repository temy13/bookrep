include Tweet

class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :save_title_query, only: [:auto_complete]

  # before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # # GET /answers
  # def index
  #   @answers = Answer.all
  # end
  #
  # # GET /answers/1
  # def show
  # end
  #
  # # GET /answers/new
  # def new
  #   @answer = Answer.new
  # end
  #
  # # GET /answers/1/edit
  # def edit
  # end

  # POST /answers
  #TODO: ここでtitle_dummyをtitleに変更させる
  def create
    @answer = Answer.new(answer_params)
    @answer.is_anonymous = params[:anonymous].present?

    if @answer.save
       tweet_answer(@answer) if @answer.is_tweet #NOTICE: current_user.nameとやったほうがいいかも
       NotificationMailer.answer_nortification(@answer).deliver if @answer.is_send_email
       redirect_to ({controller: 'questions', action: 'show', id: @answer.question.id}), notice: '回答が投稿されました'
    else
      #with Error
      redirect_to controller: 'questions', action: 'show', id: @answer.question.id
    end
  end

  # # PATCH/PUT /answers/1
  # def update
  #   if @answer.update(answer_params)
  #      redirect_to @answer, notice: 'Answer was successfully updated.'
  #   else
  #      render :edit
  #   end
  # end
  #
  # # DELETE /answers/1
  # def destroy
  #   @answer.destroy
  #   redirect_to answers_url, notice: 'Answer was successfully destroyed.'
  # end

  #TODO: too many response
  def auto_complete
    q = params[:term].gsub(/\s/, "").gsub(" ", "")
    uri = Addressable::URI.parse("https://www.googleapis.com/books/v1/volumes?q=#{q}&country=JP&maxResults=40&orderBy=relevance")
    begin
      response = Net::HTTP.get_response(uri)
      result = JSON.parse(response.body)
      book_result = result["items"]
        .select{|item| item.has_key?("volumeInfo") &&  item["volumeInfo"].has_key?("title")}
        .take(40)
        .map{|item|
          {
            title: item["volumeInfo"]["title"],
            authors: item["volumeInfo"]["authors"],
            google_books_id: item["id"],
            info: item["volumeInfo"]["industryIdentifiers"]
          }
        }
      @results = Book.auto_complete_map(book_result)

      render json: @results.to_json
    rescue => e
      p e.message
    end
  end


  private
    # # Use callbacks to share common setup or constraints between actions.
    # def set_answer
    #   @answer = Answer.find(params[:id])
    # end
    def save_title_query
      @query = TitleQuery.new(user_id: current_user.try(:id), query: params[:term])
      @query.save
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:user_id, :question_id, :content, :book_id, :title, :is_tweet, :is_anonymous)
    end
end
