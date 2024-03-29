require "koala"

class FacebookWorker include Sidekiq::Worker
  def perform(q_id)

    question = Question.find(q_id)
    logger.debug "fb worker..."
    # 100.times do
    #   break unless question.image.blank?
    #   logger.debug "fb worker sleeping..."
    #   sleep 10
    # end
    # return if question.image.blank?
    logger.debug "fb worker posts..."
    @api = Koala::Facebook::API.new(ENV["FACEBOOK_PAGE_TOKEN"])
    @api.put_wall_post(question.content, {
      # "name" => "投稿ページへのリンクです",
      "link" => question.page_url,
      # "caption" => "新しい質問が投稿されました！",
      # "description" => question.content,
      # "picture" => ENV["SERVICE_HOST"] + question.image.sns.url
    })

  end

end
