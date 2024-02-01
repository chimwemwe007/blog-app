require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:post).class_name('Post').with_foreign_key(:post_id) }
    it { should belong_to(:user).class_name('User').with_foreign_key(:user_id) }
  end

  describe 'methods' do
    describe '#update_comments_counter' do
      it 'updates the comments_counter of the associated post' do
        user = create(:user)
        post = create(:post, author: user)
        comment = create(:comment, post:)

        comment.update_comments_counter

        expect(post.reload.comments_counter).to eq(1)
      end
    end
  end
end
