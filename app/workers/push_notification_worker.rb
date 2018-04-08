class PushNotificationWorker include Sidekiq::Worker

  def perform(q_id)
    q = Question.find(q_id)
    user = q.user
    pn = user.push_notification
    return unless pn.present? && pn.is_notice
    pn.answer_notice(q_id)
  end

end
