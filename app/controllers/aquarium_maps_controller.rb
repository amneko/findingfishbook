class AquariumMapsController < ApplicationController
  def index
  end

  def hokkaido
    @aquariums = Aquarium.where(prefecture_id: 1)
  end

  def tohoku
    @aquariums = Aquarium.where(prefecture_id: [2, 3, 4, 5, 6, 7])
  end

  def tokyo
    @aquariums = Aquarium.where(prefecture_id: 13)
  end

  def kanto
    @aquariums = Aquarium.where(prefecture_id: [8, 9, 10, 11, 12, 14])
  end

  def chubu
    @aquariums = Aquarium.where(prefecture_id: [15, 16, 17, 18, 19, 20, 21, 22, 23])
  end

  def kinki
    @aquariums = Aquarium.where(prefecture_id: [24, 25, 26, 27, 28, 29, 30])
  end

  def chugoku
    @aquariums = Aquarium.where(prefecture_id: [31, 32, 33, 34, 35])
  end

  def shikoku
    @aquariums = Aquarium.where(prefecture_id: [36, 37, 38, 39])
  end

  def kyushu
    @aquariums = Aquarium.where(prefecture_id: [40, 41, 42, 43, 44, 45, 46])
  end

  def okinawa
    @aquariums = Aquarium.where(prefecture_id: [47])
  end
end
