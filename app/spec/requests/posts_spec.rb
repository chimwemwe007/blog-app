# spec/controllers/posts_controller_spec.rb
require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, author: user) }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get :index, params: { user_id: user.id }
      expect(response).to render_template(:index)
    end

    it 'assigns @user and @posts' do
      get :index, params: { user_id: user.id }
      expect(assigns(:user)).to eq(user)
      expect(assigns(:posts)).to eq(user.posts)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { user_id: user.id, id: post.id }
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get :show, params: { user_id: user.id, id: post.id }
      expect(response).to render_template(:show)
    end

    it 'assigns @post' do
      get :show, params: { user_id: user.id, id: post.id }
      expect(assigns(:post)).to eq(post)
    end
  end
end
