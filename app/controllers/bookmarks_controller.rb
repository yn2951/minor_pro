class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  def create
    bookmark = current_user.bookmarks.new(topic_id: params[:topic_id])
    if bookmark.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    Bookmark.find_by(user_id: current_user.id, topic_id: params[:topic_id]).delete
    redirect_back(fallback_location: root_path)
  end
end
