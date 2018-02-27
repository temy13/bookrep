class NotificationMailer < ApplicationMailer
  default from: ENV["EMAIL"]

  def answer_nortification(answer)
    @question = answer.question
    @user = @question.user
    mail(
      subject: "あなたの質問に回答がつきました！", #件名
      to: @user.email
    ) do |format|
      format.text
    end
  end

end
