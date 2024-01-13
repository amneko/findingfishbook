class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to post_path(@comment.post), success: t('comments.create.success') }
      end
    else
      redirect_to post_path(@comment.post), danger: t('comments.create.fail')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end
end
