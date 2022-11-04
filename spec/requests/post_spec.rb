require 'rails_helper'

RSpec.describe Post, type: :request do
  context 'Index Action' do
    before(:each) do
      get "/users/#{User.first.id}/posts/"
    end
    it 'index action renders the correct template' do
      expect(response).to render_template(:index)
    end
    it 'index respone is correct' do
      expect(response.status).to eq(200)
    end

    # it 'the response body includes correct placeholder text' do
    #   expect(response.body).to include('List of all Users')
    # end
  end

  context 'Show Action' do
    before(:each) do
      get "/users/#{User.first.id}/posts/#{Post.first.id}"
    end

    it 'show action renders the correct template' do
      expect(response).to render_template(:show)
    end
    it 'show respone is correct' do
      expect(response.status).to eq(200)
    end

    # it 'the response body includes correct placeholder text' do
    #   expect(response.body).to include('post')
    # end
  end
end
