class NotificationMailer < ApplicationMailer
  default from: ENV["EMAIL"]

  def answer_nortification(answer)
    @question = answer.question
    @user = @question.user
    mail(
      subject: "【ブクリプ】あなたの質問に回答が届きました！", #件名
      to: @user.email
    ) do |format|
      format.text
    end
  end

end
