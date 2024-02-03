require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  before do
    @user1 = FactoryBot.create(:user, name: 'User1', photo: 'https://placehold.co/400')
    @user2 = FactoryBot.create(:user, name: 'User2', photo: 'https://placehold.co/400')
    FactoryBot.create(:post, author: @user1)
    FactoryBot.create(:post, author: @user2)
  end

  scenario 'I can see the username of all other users' do
    visit users_path

    expect(page).to have_content('User1')
    expect(page).to have_content('User2')
  end

  scenario 'I can see the profile picture for each user' do
    visit users_path

    expect(page).to have_css("img[src*='https://placehold.co/400']")
  end

  scenario 'I can see the number of posts each user has written' do
    visit users_path

    expect(page).to have_content('Number of posts: 1', count: 2)
  end

  scenario 'When I click on a user, I am redirected to that user\'s show page' do
    visit users_path

    click_link 'User1'

    expect(current_path).to eq(user_path(@user1))
    expect(page).to have_content('User1')
  end
end
