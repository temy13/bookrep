class ContactMailerWorker include Sidekiq::Worker

  def perform(mail, content)
    ContactMailer.contact(mail, content).deliver
  end

end
