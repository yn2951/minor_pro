class MinorsController < ApplicationController
  def create
    @minor = current_user.minors.create(topic_id: params[:topic_id])
    new_minor_count = set_counter.minor_count.next
    set_counter.update(minor_count: new_minor_count)
    @topic = @minor.topic
  end

  def destroy
    @minor = Minor.find_by(user_id: current_user.id, topic_id: params[:topic_id]).delete
    new_minor_count = set_counter.minor_count.pred
    set_counter.update(minor_count: new_minor_count)
    @topic = @minor.topic
  end
end
