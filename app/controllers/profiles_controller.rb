class ProfilesController < ApplicationController
  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)

    if @user.update(user_params)
      redirect_to profile_path, success: t('defaults.message.update', item: User.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_update', item: User.model_name.human)
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash_message', locals: { flash: { danger: flash.now[:danger] } })
        end
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :like_fish, :like_aquarium, :icon, :icon_cache)
  end
end
