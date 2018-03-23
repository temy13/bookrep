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

require 'rails_helper'
require 'support/factory_bot'

describe User do

  it 'is valid with a mail & name & password(validation & password_required? & normal_email)' do
    user = User.new(
        email: 'foo@example.com',
        name: 'foo',
        password: "password"
    )
    expect(user).to be_valid
    e_user = create(:e_user)
    expect(e_user).to be_valid
    expect(e_user.normal_email).to eq true
  end

  it 'is valid with a mail & name & twitter(validation & password_required?)' do
    user = User.new(
        email: '000000_twitter@tsuginohon.com',
        provider: "twitter",
        name: 'foo',
    )
    expect(user).to be_valid
    t_user = create(:t_user)
    expect(t_user).to be_valid
  end

  it 'update email-user with password(vaidation & update_with_password)' do
    e_user = create(:e_user)
    pass = e_user.encrypted_password
    e_user.password = nil
    expect(e_user.save).to eq true
    expect(e_user.encrypted_password).to eq pass

    e_user.password = "password2"
    expect(e_user.save).to eq true
    expect(e_user.encrypted_password).not_to eq pass
  end

  it 'update twitter-user with blank password(vaidation & update_with_password)' do
    t_user = create(:t_user)
    t_user.password = nil
    expect(t_user.save).to eq true
  end

  it 'dummy_email'
  it 'twitter auth(from_omniauth)'
  it 'sessison(new_with_session)'

  it 'question length & answer length with anonymous(answers_length, questions_length)' do
    t_user = create(:t_user) do |u|
      u.questions.create(FactoryBot.attributes_for(:question))
      u.questions.create(FactoryBot.attributes_for(:question_anonymous))
      # u.answers.create(FactoryBot.attributes_for(:answer_anonymous_q2))
      # u.answers.create(FactoryBot.attributes_for(:answer_q1))
    end
    a = build(:answer_q1)
    a.user = t_user
    a.save
    a = build(:answer_anonymous_q2)
    a.user = t_user
    a.save
    e_user = create(:e_user)
    expect(t_user.answers_length(t_user)).to eq 2
    expect(t_user.questions_length(t_user)).to eq 2
    expect(t_user.questions_length(e_user)).to eq 1
    expect(t_user.answers_length(e_user)).to eq 1
    expect(t_user.questions_length(nil)).to eq 1
    expect(t_user.answers_length(nil)).to eq 1
  end

  it 'icon icon_path blank -> generate & save' do
    t_user = build(:t_user)
    path = t_user.icon
    pathes = ["/assets/icons/1", "/assets/icons/2", "/assets/icons/3", "/assets/icons/4", "/assets/icons/5", "/assets/icons/6"]
    expect(pathes).to include(path)
    expect(path).to eq t_user.icon_path
  end

  it 'liked' do
    e_user = create(:e_user)
    a = create(:answer_tu_q1)
    a2 = build(:answer_anonymous_q2)
    a2.user = a.user
    a2.save
    l = build(:like_true)
    l.user = e_user
    l.answer = a
    l.save
    l = build(:like_false)
    l.user = e_user
    l.answer = a2
    l.save
    expect(e_user.liked(a)).to eq true
    expect(e_user.liked(a2)).to eq false

  end

end
