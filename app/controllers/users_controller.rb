class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @user = User.find(params[:id])
    @profile = Profile.find_by(user_id: @user.id)
    @post_topics = Topic.where(user_id: params[:id]).order('created_at DESC').includes(:good_users, :minor_users, :bookmark_users)
    @post_topics_count = @post_topics.count
    @user_followers_count = @user.follows.count
    @user_follows_count = Follow.where(follower_id: @user.id).count
  end

  def list
    @user = User.find(params[:id])
    @templete = params[:templete]

    if @templete == 'bookmark_topic'
      @bookmark_topics = @user.bookmark_topics.order('created_at DESC')
    elsif @templete == 'follow_user'
      @follow_users = User.joins(:follows).where(follows: {follower_id: @user.id}).order('created_at DESC')
    else
      @post_topics = Topic.where(user_id: params[:id]).order('created_at DESC')
    end
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
