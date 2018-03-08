class ClickLogsController < ApplicationController
  def book_affiliate
    field = params[:field]
    @log = BookClickLog.new(book_id: field[:book_id], answer_id: field[:answer_id], user_id: field[:user_id])
    @log.save
    render json: @log.to_json
  end
end
