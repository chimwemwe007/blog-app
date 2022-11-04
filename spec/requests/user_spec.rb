require 'rails_helper'

RSpec.describe User, type: :request do
  context 'Index Action' do
    before(:each) do
      get '/users/'
    end
    it 'index action renders the correct template' do
      expect(response).to render_template(:index)
    end
    it 'index respone is correct' do
      expect(response.status).to eq(200)
    end

    # it 'the response body includes correct placeholder text' do
    #   expect(response.body).to include('list of all users')
    # end
  end

  context 'Show Action' do
    before(:each) do
      get '/users/1'
    end

    it 'show action renders the correct template' do
      expect(response).to render_template(:show)
    end
    it 'show respone is correct' do
      expect(response.status).to eq(200)
    end

    # it 'the response body includes correct placeholder text' do
    #   expect(response.body).to include("user")
    # end
  end
end
