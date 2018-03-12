FactoryBot.define do
  factory :t_user, class: User do
    provider "twitter"
    uid "000000"
    name "テストくん"
    email "000000-twitter@tsuginohon.com"
  end

  factory :e_user, class: User do
    name "テストさん"
    email "test0000e@ex.com"
    password "password"
  end

  pass = Faker::Internet.password(8)
  factory :user do
    name                  Faker::Name.name
    email                 Faker::Internet.email
    password              pass
    password_confirmation pass
  end


  factory :user_d1, class: User do
    name "テストさん"
    email "test0000e1@ex.com"
    password "password"
  end

  factory :user_d2, class: User do
    name "テストさん"
    email "test0000e2@ex.com"
    password "password"
  end

  factory :user_d3, class: User do
    name "テストさん"
    email "test0000e3@ex.com"
    password "password"
  end


end
