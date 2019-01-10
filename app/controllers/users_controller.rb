class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @user = User.find(params[:id])
    @post_topics = Topic.where(user_id: @user.id).includes(:good_users, :minor_users, :bookmark_users)
    @bookmark_topics = @user.bookmark_topics
    @post_topics_count = @post_topics.count
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, success: '登録しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end

  def update
    user = User.find(current_user.id)
    if user.update(profile: params[:profile])
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def user_params
    params.require(:user).permit(:image, :name, :email, :password, :password_confirmation)
  end
end
