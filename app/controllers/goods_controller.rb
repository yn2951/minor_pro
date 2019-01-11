class GoodsController < ApplicationController
  def create
    @good = current_user.goods.create(topic_id: params[:topic_id])
    @topic = @good.topic
  end

  def destroy
    @good = Good.find_by(user_id: current_user.id, topic_id: params[:topic_id]).delete
    @topic = @good.topic
  end
end
