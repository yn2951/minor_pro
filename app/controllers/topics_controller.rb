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
    @category = params[:category]
    @genre = params[:genre]
    @keyword = params[:keyword]
    @category_title = params[:category_title] ? params[:category_title] : "カテゴリー選択"
    @genre_title = params[:genre_title] ? params[:genre_title] : "ジャンル選択"
    @sort_title = params[:sort_title] ? params[:sort_title] : "投稿日時が新しい"
    @rises = Topic.eager_load(:counter).category_search(@category).genre_search(@genre).search(@keyword).order("totalize_result DESC", {created_at: :desc}).limit(5)
    @topics = Topic.joins(:user, :counter).includes(:good_users, :minor_users, :bookmark_users).category_search(@category).genre_search(@genre).search(@keyword).order(sort_column + ' ' + sort_direction, {created_at: :desc}).page(params[:page]).per(15)
  end

  def detail
    @topic = Topic.find(params[:id])
    @comment = Comment.new
    @comments = @topic.comments.order('created_at DESC').page(params[:page]).per(15)
  end

  def create
    topic = current_user.topics.new(topic_params)
    counter = topic.build_counter

    if topic.save && counter.save
      redirect_to root_path, success: "投稿しました"
    else
      redirect_to new_topic_path, danger: "投稿に失敗しました"
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

  def destroy
    if params[:user_id] == current_user.id
      Topic.find(params[:topic_id]).delete
    end
    redirect_to users_path(id: current_user.id), success: '投稿を削除しました'
  end

  private
  def topic_params
    params.require(:topic).permit(:category, :genre, :title, :image, :description)
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
