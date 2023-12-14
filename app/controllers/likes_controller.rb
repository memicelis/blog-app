class LikesController < ApplicationController
  before_action :set_user_and_post

  def create
    @like = current_user.likes.new
    @like.post = @post

    return unless @like.save

    redirect_to user_post_path(@user, @post)
  end

  private

  def set_user_and_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end
end
