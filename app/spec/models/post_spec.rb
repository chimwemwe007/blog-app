require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:author_id) }
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'methods' do
    describe '#update_post_counter' do
      it 'updates the posts_counter of the author' do
        user = create(:user)
        post = create(:post, author: user)

        post.update_post_counter

        expect(user.reload.posts_counter).to eq(1)
      end
    end

    describe '#recent_comments' do
      it 'returns the 5 most recent comments' do
        user = create(:user)
        post = create(:post, author: user)
        comment1 = create(:comment, post:, created_at: 5.days.ago)
        comment2 = create(:comment, post:, created_at: 3.days.ago)
        comment3 = create(:comment, post:, created_at: 1.day.ago)

        recent_comments = post.recent_comments

        expect(recent_comments).to match_array([comment3, comment2, comment1])
      end

      it 'returns the specified number of most recent comments' do
        post = create(:post)
        create(:comment, post:, created_at: 5.days.ago)
        comment2 = create(:comment, post:, created_at: 3.days.ago)
        comment3 = create(:comment, post:, created_at: 1.day.ago)
        create(:comment, post:, created_at: 7.days.ago)

        recent_comments = post.recent_comments(2)

        expect(recent_comments).to eq([comment3, comment2])
      end
    end
  end
end
