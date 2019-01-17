class ProfilesController < ApplicationController
  def edit
    set_profile
  end

  def update
    if set_profile.update(profile_params)
      redirect_to users_path(id: current_user.id), success: '編集を保存しました'
    else
      flash.now[:danger] = "編集の保存に失敗しました"
      render :edit
    end
  end

  private
  def set_profile
    @profile = Profile.find_by(user_id: current_user.id)
  end

  def profile_params
    params.require(:profile).permit(:image, :introduce)
  end
end
