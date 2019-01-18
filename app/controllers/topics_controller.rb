class TopicsController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def new
    @topic = Topic.new
  end

  def index
    @topics = Topic.joins(:user).all.search(params[:keyword]).order(sort_column + ' ' + sort_direction).includes(:good_users, :minor_users, :bookmark_users)
  end

  def detail
    @topic = Topic.find(params[:id])
    @comment = Comment.new
    @comments = Comment.all.order('created_at DESC')
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

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end

  def sort_column
    Topic.joins(:user).column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
end
