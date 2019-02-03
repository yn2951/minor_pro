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
      @bookmark_topics = @user.bookmark_topics.order('created_at DESC').includes(:good_users, :minor_users, :bookmark_users).page(params[:page]).per(32)
    elsif @templete == 'follow_user'
      @following_users = User.joins(:follows).where(follows: {follower_id: @user}).order('created_at DESC').page(params[:page]).per(32)
    else
      @post_topics = @user.topics.order('created_at DESC').page(params[:page]).per(32)
    end
  end

  def create
    @user = User.new(user_params)
    profile = @user.build_profile

    if User.find_by(email: @user.email).nil?
      if @user.save && profile.save
        UserResisterationMailer.welcome(@user).deliver_now
        redirect_to root_path, success: 'メールを送信しました'
      else
        redirect_to new_user_path, danger: '登録に失敗しました'
      end
    else
      redirect_to new_user_path, danger: 'メールアドレスが既に登録されています'
    end
  end

  def resisteration_done
    user = User.find(request.url.split('/').last.to_i)
    if user.profile.nil?
      profile = user.build_profile
      if profile.save
        redirect_to root_path, success: '登録が完了しました'
      else
        redirect_to root_path, danger: '登録に失敗しました'
      end
    else
      redirect_to root_path, danger: '既に登録されています'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
