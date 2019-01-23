class BookmarksController < ApplicationController
  def create
    @bookmark = current_user.bookmarks.create(topic_id: params[:topic_id])
    new_bookmark_count = set_counter.bookmark_count.next
    set_counter.update(bookmark_count: new_bookmark_count)
    @topic = @bookmark.topic
  end

  def destroy
    @bookmark = Bookmark.find_by(user_id: current_user, topic_id: params[:topic_id]).delete
    new_bookmark_count = set_counter.bookmark_count.pred
    set_counter.update(bookmark_count: new_bookmark_count)
    @topic = @bookmark.topic
  end
end
