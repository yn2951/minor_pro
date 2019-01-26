class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      new_comment_count = set_counter.comment_count.next
      set_counter.update(comment_count: new_comment_count)
      redirect_to detail_path(id: params[:topic_id]), success: "コメントを投稿しました"
    else
      redirect_to detail_path(id: params[:topic_id]), danger: "コメントに失敗しました"
    end
  end

  def comment_params
    params.require(:comment).permit(:topic_id, :text)
  end
end
