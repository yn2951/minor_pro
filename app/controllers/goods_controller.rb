class GoodsController < ApplicationController
  def create
    @good = current_user.goods.create(topic_id: params[:topic_id])
    new_good_count = set_counter.good_count.next
    set_counter.update(good_count: new_good_count)
    @topic = @good.topic
  end

  def destroy
    @good = Good.find_by(user_id: current_user, topic_id: params[:topic_id]).delete
    new_good_count = set_counter.good_count.pred
    set_counter.update(good_count: new_good_count)
    @topic = @good.topic
  end
end
