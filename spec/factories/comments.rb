FactoryBot.define do
  FactoryBot.define do
    factory :comment do
      body { 'comment' }
      association :commentable, factory: :question
    end
  end
end
