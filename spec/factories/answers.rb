FactoryBot.define do
  factory :answer do
    sequence(:body) { |n| "My text № #{n}" }
    association :question, factory: :question
    association :user, factory: :user

    trait :invalid do
      body { nil }
    end
  end
end
