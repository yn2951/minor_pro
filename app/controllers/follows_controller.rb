class FollowsController < ApplicationController
  def create
    @follow = Follow.create(user_id: params[:user_id], follower_id: current_user.id)
    @user = @follow.user
    @count_follows = @user.follows.count
  end

  def destroy
    @follow = Follow.find_by(user_id: params[:user_id], follower_id: current_user.id).delete
    @user = @follow.user
    @count_follows = @user.follows.count
  end
end
