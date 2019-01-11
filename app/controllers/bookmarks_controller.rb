class BookmarksController < ApplicationController
  def create
    @bookmark = current_user.bookmarks.create(topic_id: params[:topic_id])
    @topic = @bookmark.topic
  end

  def destroy
    @bookmark = Bookmark.find_by(user_id: current_user.id, topic_id: params[:topic_id]).delete
    @topic = @bookmark.topic
  end
end
