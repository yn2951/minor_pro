class TopicsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def new
    if !logged_in?
      redirect_to login_path
    else
      @topic = Topic.new
    end
  end

  def index
    @title = params[:title] ? params[:title] : "投稿日時が新しい"
    @keyword = params[:keyword]
    @topics = Topic.joins(:user, :counter).all.search(@keyword).order(sort_column + ' ' + sort_direction, {created_at: :desc}).includes(:good_users, :minor_users, :bookmark_users)
  end

  def detail
    @topic = Topic.find(params[:id])
    @comment = Comment.new
    @comments = @topic.comments.order('created_at DESC')
  end

  def create
    topic = current_user.topics.create(topic_params)
    counter = topic.build_counter

    if counter.save
      redirect_to root_path, success: "投稿しました"
    else
      flash.new[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:title, :image, :description)
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end

  def sort_column
    %w[created_at good_count minor_count bookmark_count comment_count].include?(params[:sort]) ? params[:sort] : "created_at"
  end
end
