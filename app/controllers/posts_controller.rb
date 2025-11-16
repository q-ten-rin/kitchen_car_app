class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path, notice: "投稿しました"
    else
      flash.now[:danger] = "投稿できませんでした"
      render :new
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy
    redirect_to posts_path, notice: "削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:title, :category, :place, :visited_at, :kitchen_car_name, :body)
  end
end
