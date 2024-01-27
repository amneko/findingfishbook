# frozen_string_literal: true

# CommentsController
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

    if update_comment
      handle_update_success
    else
      handle_update_failure
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

  def update_comment
    @comment.update(comment_update_params)
  end

  def handle_update_success
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to post_path(@comment.post), success: t('comments.create.success') }
    end
  end

  def handle_update_failure
    redirect_to post_path(@comment.post), danger: t('comments.create.fail')
  end
end
