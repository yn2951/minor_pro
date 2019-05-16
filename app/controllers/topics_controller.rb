class TopicsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_topic, only: [:edit, :update]
  before_action :keys, only: [:index, :search]

  def new
    if !user_signed_in?
      redirect_to new_user_session_path, notice: 'ログインして下さい。'
    else
      @topic = Topic.new
    end
  end

  def edit
  end

  def index
    if current_user && current_user.profile.nil?
      User.remove_same_email(current_user)
      current_user.build_profile.save
    end

    @rises = Topic.joins_table.order("totalize_result DESC", "good_count DESC", {created_at: :desc}).limit(4)
    @topics = Topic.joins_table.page(params[:page]).per(24)
  end

  def search
    @category = params[:category]
    @genre = params[:genre]
    @keyword = params[:keyword]
    @column = params[:sort]
    @direction = params[:direction]
    @category_title = params[:category_title] ? params[:category_title] : "カテゴリー未選択"
    @genre_title = params[:genre_title] ? params[:genre_title] : "ジャンル未選択"
    @sort_title = params[:sort_title] ? params[:sort_title] : "投稿日時が新しい"
    search_table = Topic.search_table(@category, @genre, @keyword)
    @rises = search_table.order("totalize_result DESC", "good_count DESC", {created_at: :desc}).limit(4)
    @topics = search_table.sort_table(sort_column, sort_direction).page(params[:page]).per(24)
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
      redirect_to root_path, notice: "投稿しました。"
    else
      flash.now[:alert] = "入力されていない項目があります。"
      @topic = Topic.new(topic_params)
      render :new
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to detail_path(id: params[:id]), notice: '編集を保存しました。'
    else
      flash.now[:alert] = '入力されていない項目があります。'
      @topic = Topic.new(topic_params)
      render :edit
    end
  end

  def destroy
    if set_topic.user == current_user
      set_topic.delete
    end

    redirect_to users_path(id: current_user.id), notice: '投稿を削除しました。'
  end

  def overview
  end

  private
  def topic_params
    params.require(:topic).permit(:category, :genre, :title, :image, :description)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def keys
    @category_keys = Topic.categories_i18n
    @genre_keys = Topic.genres_i18n
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end

  def sort_column
    %w[created_at good_count minor_count bookmark_count comment_count].include?(params[:sort]) ? params[:sort] : "created_at"
  end
end
