# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    photo { 'https://placehold.co/400' }
    bio { Faker::Lorem.sentence }
    posts_counter { 0 }
  end
end
