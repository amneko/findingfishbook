# frozen_string_literal: true

# AdminUsersController
class Admin::UsersController < Admin::BaseController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if update_user_successfully?
      handle_successful_update
    else
      handle_failed_update
    end
  end

  def destroy
    user_to_destroy = User.find(params[:id])
    if user_to_destroy.destroy
      redirect_to admin_users_path, status: :see_other, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render_or_stream(:edit)
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :email, :like_fish, :like_aquarium, :icon, :icon_cache
    )
  end

  def update_user_successfully?
    @user.update(user_params)
  end

  def handle_successful_update
    redirect_to admin_user_path(@user), success: t('defaults.message.update', item: User.model_name.human)
  end

  def handle_failed_update
    flash.now['danger'] = t('defaults.message.not_update', item: User.model_name.human)
    render_or_stream(:edit)
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
