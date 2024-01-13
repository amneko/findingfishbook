class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = current_user
    if @user.destroy
      redirect_to root_path, status: :see_other, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon, :like_fish, :like_aquarium, :role)
  end
end
