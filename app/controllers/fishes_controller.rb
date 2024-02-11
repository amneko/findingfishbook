# frozen_string_literal: true

# FishesController
class FishesController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @fishes = Fish.includes(:location).all.order(id: :asc)
  end

  def show
    @fish = Fish.find(params[:id])
    @aquarium_with_fish = aquarium_with_fish(@fish)
    @post_with_fish = post_with_fish(@fish)
  end

  private

  def aquarium_with_fish(fish)
    Post.where(fish_id: fish.id).includes(:aquarium).select(:aquarium_id).distinct
  end

  def post_with_fish(fish)
    Post.where(fish_id: fish.id)
  end
end
