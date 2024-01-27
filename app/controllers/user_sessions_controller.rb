# frozen_string_literal: true

# UserSessionsController
class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create guest_login]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to root_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, success: t('.success')
  end

  def guest_login
    redirect_to root_path, alert: t('.fail') if current_user

    @user = create_guest_user
    auto_login(@user)
    redirect_to root_path, success: t('.success')
  end

  private

  def create_guest_user
    random_value = SecureRandom.alphanumeric(10)
    User.create!(
      name: "ゲスト_#{random_value}",
      email: "guest_#{random_value}@example.com",
      password: 'password',
      password_confirmation: 'password',
      role: :guest
    )
  end
end
