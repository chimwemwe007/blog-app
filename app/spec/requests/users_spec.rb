# spec/controllers/users_controller_spec.rb

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns @users with all users' do
      user1 = create(:user)
      user2 = create(:user)
      get :index
      expect(assigns(:users)).to match_array([user1, user2])
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }

    it 'returns a successful response' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end

    it 'assigns @user and @posts for the specified user' do
      post1 = create(:post, author: user)
      post2 = create(:post, author: user)
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
      expect(assigns(:posts)).to match_array([post1, post2])
    end
  end
end
