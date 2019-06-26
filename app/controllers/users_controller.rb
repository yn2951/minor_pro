class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    if current_user && current_user.profile.nil?
      User.remove_same_email(current_user)
      current_user.build_profile.save
    end
    
    @user = User.find(params[:id])
    @profile = @user.profile
    @post_topics_count = @user.topics.count
    @user_followers_count = @user.follows.count
    @user_followings_count = Follow.where(follower_id: @user).count

    @templete = params[:templete]
    if @templete == 'bookmark_topic'
      @bookmark_topics = User.get_bookmarks(@user).page(params[:page]).per(32)
    elsif @templete == 'follow_user'
      @following_users = User.get_followings(@user).page(params[:page]).per(32)
    else
      @post_topics = User.get_posts(@user).page(params[:page]).per(32)
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserResisterationMailer.welcome(@user).deliver_now
      redirect_to root_path, notice: 'メールを送信しました'
    else
      redirect_to new_user_path, alert: '登録に失敗しました'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
