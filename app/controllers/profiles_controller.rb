# frozen_string_literal: true

# ProfilesController
class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if update_user_successfully?
      handle_successful_update
    else
      handle_failed_update
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :like_fish, :like_aquarium, :icon, :icon_cache)
  end

  def update_user_successfully?
    @user.update(user_params)
  end

  def handle_successful_update
    redirect_to profile_path, success: t('defaults.message.update', item: User.model_name.human)
  end

  def handle_failed_update
    flash.now['danger'] = t('defaults.message.not_update', item: User.model_name.human)
    render_or_stream(:edit)
  end

  def render_or_stream(action)
    respond_to do |format|
      format.html { render action, status: :unprocessable_entity }
      format.turbo_stream { render_turbo_stream_flash_message }
    end
  end

  def render_turbo_stream_flash_message
    render turbo_stream: turbo_stream.update(
      'flash',
      partial: 'shared/flash_message',
      locals: { flash: { danger: flash.now[:danger] } }
    )
  end
end
