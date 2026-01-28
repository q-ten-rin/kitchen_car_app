class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show
    @profile = User.find(params[:id])
    @favorite_posts = @profile.favorite_posts.includes(:user).page(params[:page]).per(6)
  end

  def edit; end

  def update
    if @profile.update(user_params)
      redirect_to profile_path(@profile), notice: "更新しました"
    else
      render :edit
    end
  end

  private

  def set_user
    @profile = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :avatar)
  end
end
