# frozen_string_literal: true

# AquariumsController
class AquariumsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @q = Aquarium.ransack(params[:q])
    @aquariums = @q.result.includes(:prefecture)
  end

  def show
    @aquarium = Aquarium.find(params[:id])
    @fish_in_aquarium = fish_in_aquarium(@aquarium)
    @post_with_aquarium = post_with_aquarium(@aquarium)
  end

  private

  def fish_in_aquarium(aquarium)
    Post.where(aquarium_id: aquarium.id).includes(:fish).select(:fish_id).distinct
  end

  def post_with_aquarium(aquarium)
    Post.where(aquarium_id: aquarium.id)
  end
end
