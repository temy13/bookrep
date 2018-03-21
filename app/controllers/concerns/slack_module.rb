# module SlackModule extend ActiveSupport::Concern
#
#   def question_slack(question)
#     notifier = Slack::Notifier.new(ENV["SLACK_QUESTIONS"])
#     notifier.ping(question.content + " " + ENV["SERVICE_HOST"] + "/questions/" + question.id.to_s)
#   end
# end
