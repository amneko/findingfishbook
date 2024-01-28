# frozen_string_literal: true

# ContactsController
class ContactsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index; end
end
