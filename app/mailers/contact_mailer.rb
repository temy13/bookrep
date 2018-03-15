class ContactMailer < ApplicationMailer
  default from: ENV["EMAIL"]
  default to: ENV["EMAIL"]

  def contact(email, content)
    @email = email
    @content = content
    mail(
      subject: "お問い合わせ" #件名
    ) do |format|
      format.text
    end

  end

end
