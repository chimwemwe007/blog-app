require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:posts).with_foreign_key(:author_id).dependent(:destroy) }
  end

  describe 'methods' do
    describe '#recent_posts' do
      it 'returns the 3 most recent posts' do
        user = create(:user)
        post1 = create(:post, author: user, created_at: 5.days.ago)
        post2 = create(:post, author: user, created_at: 3.days.ago)
        post3 = create(:post, author: user, created_at: 1.day.ago)
        create(:post, author: user, created_at: 7.days.ago)

        recent_posts = user.recent_posts

        expect(recent_posts).to eq([post3, post2, post1])
      end

      it 'returns the specified number of most recent posts' do
        user = create(:user)
        create(:post, author: user, created_at: 5.days.ago)
        post2 = create(:post, author: user, created_at: 3.days.ago)
        post3 = create(:post, author: user, created_at: 1.day.ago)
        create(:post, author: user, created_at: 7.days.ago)

        recent_posts = user.recent_posts(2)

        expect(recent_posts).to eq([post3, post2])
      end
    end
  end
end
