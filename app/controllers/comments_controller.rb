class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.create(comment_params)
    new_comment_count = set_counter.comment_count.next
    set_counter.update(comment_count: new_comment_count)

    redirect_to detail_path(id: params[:topic_id]), success: "コメントを投稿しました。"
  end

  def comment_params
    params.require(:comment).permit(:topic_id, :text)
  end
end
