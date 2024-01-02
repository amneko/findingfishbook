class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end  
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :fish_id, :aquarium_id, :post_image, :shooting_date, :body)
  end

end
