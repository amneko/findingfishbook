# frozen_string_literal: true

# PasswordResetsController
class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!
    redirect_to login_path
    flash[:success] = t('.success')
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    handle_authentication_failure && return if @user.blank?

    handle_password_change
  end

  private

  def handle_authentication_failure
    not_authenticated
  end

  def handle_password_change
    @user.password_confirmation = params.dig(:user, :password_confirmation)

    if @user.change_password(params.dig(:user, :password))
      handle_password_change_success
    else
      handle_password_change_failure
    end
  end

  def handle_password_change_success
    redirect_to login_path
    flash[:success] = t('.success')
  end

  def handle_password_change_failure
    render :edit
  end
end
