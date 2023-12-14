class CommentsController < ApplicationController
  before_action :set_user_and_post

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post = @post

    if @comment.save
      flash[:notice] = 'Comment created successfully'
    else
      flash[:alert] = 'Comment has to have at least two letters'
    end
    redirect_to user_post_path(@user, @post)
  end
  
  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to user_post_path(@user,@post)
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
