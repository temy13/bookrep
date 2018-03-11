FactoryBot.define do
  factory :answer_tu_q1, class: Answer do
    content "ノット匿名回答"
    title "タイトル"
    is_anonymous false
    association :question, factory: :question_u1
    association :user, factory: :t_user
  end

  factory :answer_anonymous_tu_q2, class: Answer do
    content "匿名回答"
    title "匿名タイトル"
    is_anonymous true
    association :question, factory: :question_u2
    association :user, factory: :t_user
  end

  factory :answer_anonymous_eu_q3, class: Answer do
    content "匿名回答"
    title "匿名タイトル"
    is_anonymous true
    association :question, factory: :question_u3
    association :user, factory: :e_user
  end


  factory :answer, class: Answer do
    content "ノット匿名回答"
    title "タイトル"
    is_anonymous false
    association :question, factory: :question
    association :user, factory: :user
  end

  factory :answer_nu_nq, class: Answer do
    content "ノット匿名回答"
    title "タイトル"
    is_anonymous false
  end

  factory :answer_anonymous_nu_nq, class: Answer do
    content "ノット匿名回答"
    title "タイトル"
    is_anonymous true
  end


  factory :answer_u2, class: Answer do
    content "ノット匿名回答"
    title "タイトル"
    is_anonymous false
    association :user, factory: :user_d2
  end


  factory :answer_q1, class: Answer do
    content "ノット匿名回答"
    title "タイトル"
    is_anonymous false
    association :question, factory: :question_u1
  end

  factory :answer_anonymous_q2, class: Answer do
    content "匿名回答"
    title "匿名タイトル"
    is_anonymous true
    association :question, factory: :question_u2
  end

end
