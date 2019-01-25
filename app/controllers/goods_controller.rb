class GoodsController < ApplicationController
  def create
    @good = current_user.goods.create(topic_id: params[:topic_id])
    new_good_count = set_counter.good_count.next
    new_good_totalize = set_counter.good_totalize.next
    new_totalize_result = set_counter.totalize_result.next
    set_counter.update(good_count: new_good_count, good_totalize: new_good_totalize, totalize_result: new_totalize_result)
    @topic = @good.topic
  end

  def destroy
    @good = Good.find_by(user_id: current_user, topic_id: params[:topic_id]).delete
    new_good_count = set_counter.good_count.pred
    new_good_totalize = set_counter.good_totalize.pred
    new_totalize_result = set_counter.totalize_result.pred
    set_counter.update(good_count: new_good_count, good_totalize: new_good_totalize, totalize_result: new_totalize_result)
    @topic = @good.topic
  end
end
