class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @user = User.find(params[:id])
    @profile = @user.profile
    @post_topics_count = @user.topics.count
    @user_followers_count = @user.follows.count
    @user_followings_count = Follow.where(follower_id: @user).count

    @templete = params[:templete]
    if @templete == 'bookmark_topic'
      @bookmark_topics = @user.bookmark_topics.order('created_at DESC').includes(:good_users, :minor_users, :bookmark_users).page(params[:page]).per(6)
    elsif @templete == 'follow_user'
      @following_users = User.joins(:follows).where(follows: {follower_id: @user}).order('created_at DESC').page(params[:page]).per(6)
    else
      @post_topics = @user.topics.order('created_at DESC').page(params[:page]).per(2)
    end
  end

  def create
    user = User.create(user_params)
    profile = user.build_profile

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
