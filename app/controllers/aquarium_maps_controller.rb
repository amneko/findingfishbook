# frozen_string_literal: true

# AquariumMapsController
class AquariumMapsController < ApplicationController
  before_action :view_map, only: %i[hokkaido tohoku tokyo kanto chubu kinki chugoku shikoku kyushu okinawa]

  PREFECTURE_IDS = {
    hokkaido: [1],
    tohoku: [2, 3, 4, 5, 6, 7],
    tokyo: [13],
    kanto: [8, 9, 10, 11, 12, 14],
    chubu: [15, 16, 17, 18, 19, 20, 21, 22, 23],
    kinki: [24, 25, 26, 27, 28, 29, 30],
    chugoku: [31, 32, 33, 34, 35],
    shikoku: [36, 37, 38, 39],
    kyushu: [40, 41, 42, 43, 44, 45, 46],
    okinawa: [47]
  }.freeze

  def index; end

  PREFECTURE_IDS.each do |region, ids|
    define_method(region) do
      @aquariums = Aquarium.where(prefecture_id: ids)
    end
  end

  private

  def view_map
    @google_maps_api_url = "https://maps.googleapis.com/maps/api/js?key=#{Rails.application.config.google_maps_api_key}&callback=initMap"
  end
end
