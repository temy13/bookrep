class NotificationMailerWorker include Sidekiq::Worker

  def perform(a_id)
    @answer = Answer.find(a_id)
    NotificationMailer.answer_nortification(@answer).deliver
  end

end
