FactoryBot.define do
  factory :like do
    association :user
    association :post
    created_at { Time.current }
  end
end
