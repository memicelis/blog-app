class Api::PostsController < ApplicationController
  def index
    current_user = User.find(params[:user_id])
    posts = current_user.posts
    render json: posts
  end
end
