class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
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

  def update
    @post = current_user.posts.find(params[:id])

    if params[:post][:post_image].present?
      post_image = File.open(params[:post][:post_image].tempfile)
      result = Vision.image_analysis(post_image)
    else
      result = true
    end

    if result == true
      if @post.update(post_params)
        redirect_to post_path(@post), success: t('.success')
      else
        flash.now[:danger] = t('.fail')
        respond_to do |format|
          format.html { render :edit, status: :unprocessable_entity }
          format.turbo_stream do
            render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash_message', locals: { flash: { danger: flash.now[:danger] } })          
          end
        end
      end
    elsif result == false
      flash.now[:danger] = t('.fish_fail')
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash_message', locals: { flash: { danger: flash.now[:danger] } })
        end
      end
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path, status: :see_other, success: t('.success')
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :fish_id, :aquarium_id, :post_image, :post_image_cache, :shooting_date, :body)
  end

end
