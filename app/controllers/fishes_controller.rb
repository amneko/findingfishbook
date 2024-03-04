# frozen_string_literal: true

# FishesController
class FishesController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @fishes = Fish.includes(:location).all.order(id: :asc)
  end

  def show
    @fish = Fish.find(params[:id])
    @aquarium_with_fish = Post.aquariums_with_fish(@fish.id)
    @post_with_fish = Post.with_fish(@fish.id)
  end
end
