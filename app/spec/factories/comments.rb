FactoryBot.define do
  factory :comment do
    sequence(:text) { |n| "Comment content #{n}" }
    association :post
    association :user
    created_at { Time.current }
  end
end
