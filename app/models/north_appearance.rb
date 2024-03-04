# frozen_string_literal: true

# NorthAppearance
class NorthAppearance < ApplicationRecord
  belongs_to :fish

  scope :now_fishes, ->(month, time) {
    where(north_month: month)
    .where(
    "(? BETWEEN latenight_starttime AND latenight_endtime) OR
    (? BETWEEN morning_starttime AND morning_endtime) OR
    (? BETWEEN noon_starttime AND noon_endtime) OR
    (? BETWEEN evening_starttime AND evening_endtime) OR
    (? BETWEEN night_starttime AND night_endtime)",
    time, time, time, time, time
    )
    .pluck(:fish_id)
  }
end
