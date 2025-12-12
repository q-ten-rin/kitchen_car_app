class PostsController < ApplicationController
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    tag_names = params[:post][:tag_names]

    if @post.save
      if tag_names.present?
        tags = tag_names.split(",").reject(&:blank?).uniq
        create_or_update_post_tags(@post, tags)
      end
      redirect_to posts_path, notice: "投稿しました"
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

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    tag_names = params[:post][:tag_names]

    if @post.update(post_params)
      if tag_names.present?
        tags = tag_names.split(",").reject(&:blank?).uniq
        create_or_update_post_tags(@post, tags)
      end
      redirect_to posts_path, notice: "更新しました"
    else
      flash.now[:danger] = "更新できませんでした"
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :category_id, :place, :visited_at, :kitchen_car_name, :body, :star, images: [])
  end

  def create_or_update_post_tags(post, tags)
    post.post_tags.destroy_all
    begin
    tags.each do |tag|
      tag = Tag.find_or_create_by(name: tag)
      post.tags << tag
      rescue ActiveRecord::RecordInvalid
        false
      end
    end
  end
end
