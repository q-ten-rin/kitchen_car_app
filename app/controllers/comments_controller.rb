class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]
  
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
  
    @comment.save
  end
  
  def edit; end

  def update
    @comment.update(comment_params)
  end

  def destroy
    @comment.destroy!
  end
  
  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end