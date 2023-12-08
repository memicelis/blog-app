require 'rails_helper'

RSpec.describe '/posts', type: :request do
  let(:user_posts_path) { '/users/:user_id/posts' }
  let(:user_post_show_path) { '/users/:user_id/posts/:id' }

  describe 'GET /index' do
    it 'renders a successful response' do
      get user_posts_path
      expect(response).to be_successful
    end

    it 'renders correct template' do
      get user_posts_path
      expect(response).to render_template(:index)
    end

    it 'renders correct placeholder text' do
      get user_posts_path
      expect(response.body).to include('Here is a list of posts by a given user')
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get user_post_show_path
      expect(response).to be_successful
    end

    it 'renders correct template' do
      get user_post_show_path
      expect(response).to render_template(:show)
    end

    it 'renders correct placeholder text' do
      get user_post_show_path
      expect(response.body).to include('Here is a list of comments on a given post of a given user')
    end
  end
end
