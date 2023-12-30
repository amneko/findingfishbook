class AquariumsController < ApplicationController
  def index
    @aquariums = Aquarium.all
  end
end
