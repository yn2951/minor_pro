class MinorsController < ApplicationController
  def create
    @minor = current_user.minors.create(topic_id: params[:topic_id])
    @topic = @minor.topic
    @count_minors = @topic.minors.count
  end

  def destroy
    @minor = Minor.find_by(user_id: current_user.id, topic_id: params[:topic_id]).delete
    @topic = @minor.topic
    @count_minors = @topic.minors.count
  end
end
