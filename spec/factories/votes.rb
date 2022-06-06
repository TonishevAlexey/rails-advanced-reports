FactoryBot.define do
  factory :vote do
    value { 0 }
    association :user, factory: :user
  end
end
