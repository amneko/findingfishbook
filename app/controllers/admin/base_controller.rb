# frozen_string_literal: true

# AdminBaseController
class Admin::BaseController < ApplicationController
  before_action :check_admin
  layout 'admin/layouts/application'

  private

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to admin_login_path
  end

  def check_admin
    return if current_user.admin?

    flash[:warning] = t('defaults.message.not_authorized')
    redirect_to admin_login_path
  end
end
