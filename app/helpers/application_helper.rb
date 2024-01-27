# frozen_string_literal: true

# ApplicationHelper
module ApplicationHelper
  def fish_to_catch_now
    current_month = Time.zone.now.strftime('%m')
    current_time = Time.zone.now.strftime('%H:%M')
    matching_data = matching_data(current_month, current_time)
    group_fishes_by_location(matching_data)
  end

  private

  def matching_data(month, time)
    NorthAppearance.where(north_month: month)
                   .where(
                     "(? BETWEEN latenight_starttime AND latenight_endtime) OR
                     (? BETWEEN morning_starttime AND morning_endtime) OR
                     (? BETWEEN noon_starttime AND noon_endtime) OR
                     (? BETWEEN evening_starttime AND evening_endtime) OR
                     (? BETWEEN night_starttime AND night_endtime)",
                     time, time, time, time, time
                   )
                   .pluck(:fish_id)
  end

  def group_fishes_by_location(matching_data)
    fishes = Fish.where(id: matching_data).includes(:location)
    fishes.group_by(&:location)
  end
end
