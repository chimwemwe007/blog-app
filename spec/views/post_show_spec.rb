# spec/views/post_show_spec.rb

require 'rails_helper'

RSpec.describe 'posts/show.html.erb', type: :view do
  let(:user) { create(:user) }
  let(:post) { create(:post, author: user) }
  let!(:comments) { create_list(:comment, 3, post:, user: create(:user)) }

  before do
    assign(:post, post)
    assign(:comments, comments)
    render
  end

  it 'displays the post title' do
    expect(rendered).to have_css('h2', text: "Post ##{post.id} by #{post.author.name}")
  end

  it 'displays the number of comments and likes' do
    expect(rendered).to have_css('.comLik p', text: "Comments: #{comments.count}, Likes: #{post.likes.count}")
  end

  it 'displays the post body' do
    expect(rendered).to have_css('.userPost p', text: post.text)
  end

  it 'displays the comments with usernames' do
    comments.each do |comment|
      expect(rendered).to have_css('.userCom', text: "#{comment.user.name}: #{comment.text}")
    end
  end
end
