class Api::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user_and_post

  def index
    @comments = @post.comments
    render json: @comments
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = @user

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user_and_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
