class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to users_path(id: current_user), success: '編集を保存しました'
    else
      flash.now[:danger] = "編集の保存に失敗しました"
      render :edit
    end
  end

  private
  def set_profile
    @profile = Profile.find_by(user_id: current_user)
  end

  def profile_params
    params.require(:profile).permit(:image, :introduce)
  end
end
