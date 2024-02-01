# spec/factories/posts.rb
FactoryBot.define do
  factory :post do
    title { 'Sample Post Title' }
    text { 'This is a sample post content.' }
    association :author, factory: :user
    comments_counter { 0 }
    likes_counter { 0 }
  end
end
