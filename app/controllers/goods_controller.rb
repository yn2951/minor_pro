class GoodsController < ApplicationController
  def create
    good = current_user.goods.new(topic_id: params[:topic_id])
    if good.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    Good.find_by(user_id: current_user.id, topic_id: params[:topic_id]).delete
    redirect_back(fallback_location: root_path)
  end
end
