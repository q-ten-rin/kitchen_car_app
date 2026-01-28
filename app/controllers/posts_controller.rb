class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user).page(params[:page]).page(params[:page]).per(12)
  end

  def show
    @post = Post.find_by!(uuid: params[:uuid])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    tag_names = params[:post][:tag_names]

    if @post.save

      if params[:post][:images].present?
        images = params[:post][:images].reject(&:blank?)
        @post.images.attach(images)
      end

      if tag_names.present?
        tags = tag_names.split(",").reject(&:blank?).uniq
        create_or_update_post_tags(@post, tags)
      end
      redirect_to posts_path, notice: "投稿しました"
    else
      flash.now[:danger] = "投稿できませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find_by!(uuid: params[:uuid])
    post.destroy
    redirect_to posts_path, notice: "削除しました"
  end

  def edit
    @post = current_user.posts.find_by!(uuid: params[:uuid])
  end

  def update
    @post = current_user.posts.find_by!(uuid: params[:uuid])
    tag_names = params[:post][:tag_names]

    if @post.update(post_params)

      if params[:post][:images].present?
        images = params[:post][:images].reject(&:blank?)
        @post.images.attach(images) if images.any?
      end

      if tag_names.present?
        tags = tag_names.split(",").reject(&:blank?).uniq
        create_or_update_post_tags(@post, tags)
      end
      redirect_to posts_path, notice: "更新しました"
    else
      flash.now[:danger] = "更新できませんでした"
      render :edit, status: :unprocessable_entity
    end
  end

  def autocomplete
    @posts = Post.where("title like ?", "%#{params[:q]}%")
    render layout: false
  end

  private

  def post_params
    params.require(:post).permit(:title, :category_id, :place, :visited_at, :kitchen_car_name, :body, :star, :latitude, :longitude)
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
