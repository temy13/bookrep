class SlackQuestionWorker include Sidekiq::Worker

    def perform(q_id)
      question = Question.find(q_id)
      notifier = Slack::Notifier.new(ENV["SLACK_QUESTIONS"])
      notifier.ping(question.content + " " + ENV["SERVICE_HOST"] + "/questions/" + question.id.to_s)
    end

end
