class MinorsController < ApplicationController
  def create
    minor = current_user.minors.new(topic_id: params[:topic_id])
    if minor.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    Minor.find_by(user_id: current_user.id, topic_id: params[:topic_id]).delete
    redirect_back(fallback_location: root_path)
  end
end
