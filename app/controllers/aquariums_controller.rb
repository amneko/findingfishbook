class AquariumsController < ApplicationController
  def index
    @aquariums = Aquarium.all
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
