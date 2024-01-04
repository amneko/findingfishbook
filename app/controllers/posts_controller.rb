class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if params[:post][:post_image].present?
      post_image = File.open(params[:post][:post_image].tempfile)
      result = Vision.image_analysis(post_image)
    else
      result = false
    end

    if result == true
      if @post.save
        redirect_to posts_path, success: t('.success')
      else
        flash.now[:danger] = t('.fail')
        render :new, status: :unprocessable_entity
      end
    elsif result == false
      flash.now[:danger] = t('.fish_fail')
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash_message', locals: { flash: { danger: flash.now[:danger] } })
        end
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :fish_id, :aquarium_id, :post_image, :post_image_cache, :shooting_date, :body)
  end

end
