FactoryBot.define do
  factory :user do
    sequence(:email){|n| "user_#{n}@local.com"}
    sequence(:username){|n| "user_#{n}"}
    name{"User"}
    password{"123"}
  end
end
