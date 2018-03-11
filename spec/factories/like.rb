FactoryBot.define do
  factory :like_true, class: Like do
    like true
  end

  factory :like_false, class: Like do
    like false
  end

  factory :like_false_u1, class: Like do
    like false
    association :user, factory: :user_d3
  end


end
