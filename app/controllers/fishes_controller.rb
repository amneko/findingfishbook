class FishesController < ApplicationController
  def index
    @fishes = Fish.includes(:location).all
  end
end
