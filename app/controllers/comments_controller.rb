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

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = current_user.comments.find(params[:id])

    if @comment.update(comment_update_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to post_path(@comment.post), success: t('comments.create.success') }
      end
    else
      redirect_to post_path(@comment.post), danger: t('comments.create.fail')
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end

  def comment_update_params
    params.require(:comment).permit(:body)
  end
end
