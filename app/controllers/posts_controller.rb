# frozen_string_literal: true

# PostsController
class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @posts = Post.includes(:user, :fish, :aquarium).order(created_at: :desc).page(params[:page])
    @liked_post_ids = current_user.likes.pluck(:post_id).to_set if logged_in?
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    process_post(:new)
  end

  def update
    @post = current_user.posts.find(params[:id])
    process_post(:edit, update: true)
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path, status: :see_other, success: t('.success')
  end

  def likes
    @like_posts = current_user.like_posts.includes(:user).order(created_at: :desc)
    @liked_post_ids = current_user.likes.pluck(:post_id).to_set if logged_in?
  end

  private

  def post_params
    params.require(:post).permit(
      :user_id, :fish_id, :aquarium_id, :post_image,
      :post_image_cache, :shooting_date, :body
    )
  end

  def process_post(render_action, update: false)
    if analyze_and_set_result(update)
      save_or_update_post(render_action, update)
    else
      flash.now[:danger] = t('.fish_fail')
      render_or_stream(render_action)
    end
  end

  def analyze_and_set_result(update)
    analyze_post_image(params[:post][:post_image], update:)
  end

  def save_or_update_post(render_action, update)
    action_success = update ? t('posts.update.success') : t('posts.create.success')
    action_fail = update ? t('posts.update.fail') : t('posts.create.fail')

    if update
      update_post_or_render(@post, render_action, action_success, action_fail)
    else
      save_post_or_render(@post, render_action, action_success, action_fail)
    end
  end

  def analyze_post_image(post_image_param, update: false)
    return true if update && post_image_param.blank?
    return false if post_image_param.blank?

    post_image = File.open(post_image_param.tempfile)
    Vision.image_analysis(post_image)
  end

  def save_post_or_render(post, render_action, success_message, fail_message)
    if post.save
      redirect_to posts_path, success: success_message
    else
      flash.now[:danger] = fail_message
      render_or_stream(render_action)
    end
  end

  def update_post_or_render(post, render_action, success_message, fail_message)
    if post.update(post_params)
      redirect_to post_path(post), success: success_message
    else
      flash.now[:danger] = fail_message
      render_or_stream(render_action)
    end
  end

  def render_or_stream(action)
    respond_to do |format|
      format.html { render action, status: :unprocessable_entity }
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'flash',
          partial: 'shared/flash_message',
          locals: { flash: { danger: flash.now[:danger] } }
        )
      end
    end
  end
end
