class TopicsController < ApplicationController
  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      redirect_to pages_path, success: "投稿しました"
    else
      flash.new[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:category, :title, :topic_image, :description)
  end
end
