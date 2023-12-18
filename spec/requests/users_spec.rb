require 'rails_helper'

RSpec.describe '/users', type: :request do
  let(:user_show_path) { '/users/:id' }

  describe 'GET /index' do
    it 'renders a successful response' do
      get users_path
      expect(response).to be_successful
    end

    it 'renders correct template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'renders correct placeholder text' do
      get users_path
      expect(response.body).to include('List of all users')
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get user_show_path
      expect(response).to be_successful
    end

    it 'renders correct template' do
      get user_show_path
      expect(response).to render_template(:show)
    end

    it 'renders correct placeholder text' do
      get user_show_path
      expect(response.body).to include('This is a given user')
    end
  end
end
