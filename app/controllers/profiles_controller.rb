class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show
    @favorite_posts = current_user.favorite_posts.includes(:user)
  end

  def edit; end

  def update
    if @profile.update(user_params)
      redirect_to profile_path, notice: "更新しました"
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
