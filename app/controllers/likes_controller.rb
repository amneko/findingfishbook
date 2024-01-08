class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
  end

  def destroy
   like = current_user.likes.find(params[:id])
   @post = like.post
   current_user.unlike(@post)
  end
end
