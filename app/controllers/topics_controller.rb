class TopicsController < ApplicationController
  def new
    @topic = Topic.new
  end

  def index
    @topics = Topic.all.includes(:good_users, :minor_users, :bookmark_users)
  end

  def detail
    @topic = Topic.find(params[:id])
    @comment = Comment.new
    @comments = Comment.all
  end

  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      redirect_to root_path, success: "投稿しました"
    else
      flash.new[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:category, :title, :image, :description)
  end
end
