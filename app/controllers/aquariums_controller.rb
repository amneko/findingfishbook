# frozen_string_literal: true

# AquariumsController
class AquariumsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @q = Aquarium.ransack(params[:q])
    @aquariums = @q.result.includes(:prefecture).order(id: :asc)
  end

  def show
    view_map
    @aquarium = Aquarium.find(params[:id])
    @fish_in_aquarium = Post.fishes_in_aquarium(@aquarium.id)
    @post_with_aquarium = Post.with_aquarium(@aquarium.id)
  end

  private

  def view_map
    @google_maps_api_url = "https://maps.googleapis.com/maps/api/js?key=#{Rails.application.config.google_maps_api_key}&callback=initMap"
  end
end
