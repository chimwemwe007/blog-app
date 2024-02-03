require 'rails_helper'

RSpec.feature 'User posts index page', type: :feature do
  let(:user) { create(:user) }
  let!(:posts) { create_list(:post, 10, author: user) }

  scenario 'displays user information and posts' do
    visit_user_posts_page

    expect_user_information_displayed
    check_display_for_each_post

    expect_pagination_button
    click_pagination_button
    expect_redirected_to_user_posts_path
  end

  scenario 'redirects to post show page when clicking a post' do
    visit_user_posts_page

    click_first_post

    expect_redirected_to_post_show_page
  end

  private

  def visit_user_posts_page
    visit user_posts_path(user)
  end

  def expect_user_information_displayed
    expect(page).to have_selector('.userImg', visible: false, count: 1)
    expect(page).to have_css('.userName', text: user.name)
    expect(page).to have_css('.Upostcount', text: "Number of Posts: #{user.posts.count}")
  end

  def check_display_for_each_post
    user.posts.limit(5).each_with_index do |post, index|
      check_post_display(post, index)
    end
  end

  def check_post_display(post, index)
    within_post_element(index) do
      expect(page).to have_css('h2', text: "Post ##{index + 1}")
      expect(page).to have_css('.pText', text: truncate(post.text, length: 50, separator: ' '))
      expect(page).to have_css('.comLik p', text: "Comments: #{post.comments.count}, Likes: #{post.likes.count}")
      check_post_comments_displayed(post)
    end
  end

  def within_post_element(index, &)
    posts_elements = all('.recPost.postInt')
    within(posts_elements[index], &)
  end

  def check_post_comments_displayed(post)
    post.comments.limit(2).each_with_index do |comment, comment_index|
      expect(page).to have_css(".userCom:nth-child(#{comment_index + 1})",
                               text: "#{comment.user&.name || 'Anonymous'}: #{comment.text}")
    end
  end

  def expect_pagination_button
    expect(page).to have_button('Pagination', visible: true)
  end

  def click_pagination_button
    click_button('Pagination')
  end

  def expect_redirected_to_user_posts_path
    expect(page).to have_current_path(user_posts_path(user))
  end

  def click_first_post
    if page.has_css?('.recPost.postInt')
      first('.recPost.postInt').click
    else
      puts 'No posts found.'
    end
  end

  def expect_redirected_to_post_show_page
    expect(page).to have_current_path(user_post_path(user, user.posts.first))
  end
end
