# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  screen_name            :string
#  name                   :string           default("クリス"), not null
#  profile                :string
#  icon_path              :string
#  is_email_notice        :boolean          default(FALSE)
#  states_cd              :integer          default(0)
#  score                  :integer          default(0)
#

require 'securerandom'


class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable#, omniauth_providers: [:twitter]
  has_many :questions
  has_many :answers
  has_many :likes
  has_many :question_show_logs
  has_many :title_query
  has_many :book_click_logs
  has_many :action_logs
  has_many :push_notification

  as_enum :states, normal: 0, dummy: 1, admin: 2, answer_bot: 3


  # before_save :prepare_save


   def self.from_omniauth(auth)
     find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
       user.provider = auth["provider"]
       user.uid = auth["uid"]
       user.name = auth["info"]["name"]
       user.screen_name = auth["info"]["nickname"]
       user.email = User.dummy_email_auth(auth)
       user.icon_path = auth["info"]["image"].sub("_normal.", ".")
     end
   end

   def self.new_with_session(params, session)
     if session["devise.user_attributes"]
       new(session["devise.user_attributes"]) do |user|
         user.attributes = params
       end
     else
       super
     end
   end

   # providerがある場合（Twitter経由で認証した）は、
   # passwordは要求しないようにする。
   def password_required?
     super && provider.blank?
   end

   # プロフィールを変更するときによばれる
  def update_with_password(params, *options)
    if provider.present? && params[:email].blank?
      params[:email] = dummy_email(uid, provider) #params[:email] = #User.dummy_email({"uid" => self.uid, "provider" => self.provider})
    end
    # DBのパスワードが空の場合
    if encrypted_password.blank?
      # パスワードがなくても更新できる
      update_attributes(params, *options)
    else
      super
    end
  end




  def normal_email
    self.email.present? && !self.is_dummy_email
  end

  def is_dummy_email
    email == dummy_email(uid, provider)
  end

  def is_send_email
    self.is_email_notice && self.normal_email
  end

  def answers_length(current_user)
    current_user.try(:id) == self.id ? self.answers.size : self.answers.where(is_anonymous: false).size
  end

  def questions_length(current_user)
    current_user.try(:id) == self.id ? self.questions.size : self.questions.where(is_anonymous: false).size
  end

  def icon
    return self.icon_path.gsub("http://", "https://") if self.icon_path.present?
    path = "/assets/icons/" + rand(1..6).to_s
    self.icon_path = path
    self.save
    self.icon_path
  end

  def liked(answer)
    Like.where(user_id: self.id, answer_id: answer.id, like: true).size > 0
  end



  private

    def self.dummy_email_auth(auth)
      "#{auth.uid}-#{auth.provider}@tsuginohon.com"
    end

    def dummy_email(uid, provider)
      "#{uid}-#{provider}@tsuginohon.com"
    end

  #end

end
