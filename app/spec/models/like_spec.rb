require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'factory' do
    it 'is valid' do
      like = create(:like)
      expect(like).to be_valid
    end
  end
end
