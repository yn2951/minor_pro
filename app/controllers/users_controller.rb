class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @user = User.find(params[:id])
    @profile = Profile.find_by(user_id: @user.id)
    @post_topics = Topic.where(user_id: params[:id]).includes(:good_users, :minor_users, :bookmark_users)
    @bookmark_topics = @user.bookmark_topics
    @post_topics_count = @post_topics.count
  end

  def create
    user = User.create(user_params)
    profile = user.profiles.new

    if profile.save
      redirect_to root_path, success: '登録しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
