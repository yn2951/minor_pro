class TopicsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_topic, only: [:edit, :update]

  def new
    if !logged_in?
      redirect_to login_path
    else
      @topic = Topic.new
    end
  end

  def edit
  end

  def index
    @title = params[:title] ? params[:title] : "投稿日時が新しい"
    @keyword = params[:keyword]
    @rises = Topic.joins(:counter).order("variation DESC", {created_at: :desc}).limit(3)
    @topics = Topic.joins(:user, :counter).search(@keyword).order(sort_column + ' ' + sort_direction, {created_at: :desc}).includes(:good_users, :minor_users, :bookmark_users).page(params[:page]).per(6)
  end

  def detail
    @topic = Topic.find(params[:id])
    @comment = Comment.new
    @comments = @topic.comments.order('created_at DESC').page(params[:page]).per(5)
  end

  def create
    topic = current_user.topics.create(topic_params)
    counter = topic.build_counter

    if counter.save
      redirect_to root_path, success: "投稿しました"
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to detail_path(id: params[:id]), success: '編集を保存しました'
    else
      flash.now[:danger] = '編集の保存に失敗しました'
      render :edit
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:title, :image, :description)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end

  def sort_column
    %w[created_at good_count minor_count bookmark_count comment_count].include?(params[:sort]) ? params[:sort] : "created_at"
  end
end
