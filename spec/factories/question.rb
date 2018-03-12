FactoryBot.define do
  factory :question, class: Question do
    content "ノット匿名"
    association :user, factory: :user
  end

  factory :question_nu, class: Question do
    content "not匿名"
    is_anonymous true
  end
  factory :question_anonymous, class: Question do
    content "匿名"
    is_anonymous true
  end

  factory :question_u1_has_answers, class: Question do
    content "匿名"
    is_anonymous true
    association :user, factory: :user_d1
    after(:create) do |q|
      create(:answer_u2, question: q)
    end

  end


  factory :question_u1, class: Question do
    content "匿名"
    is_anonymous true
    association :user, factory: :user_d1
  end

  factory :question_u2, class: Question do
    content "匿名"
    is_anonymous true
    association :user, factory: :user_d2
  end

  factory :question_u3, class: Question do
    content "秘匿名"
    is_anonymous false
    association :user, factory: :user_d3
  end


end
