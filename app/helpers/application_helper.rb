module ApplicationHelper
  def fish_to_catch_now
    current_month = Time.zone.now.strftime("%m")
    current_time = Time.zone.now.strftime("%H:%M")
  
    matching_data = NorthAppearance.where(north_month: current_month)
                                   .where(
                                     "(? BETWEEN latenight_starttime AND latenight_endtime) OR
                                     (? BETWEEN morning_starttime AND morning_endtime) OR
                                     (? BETWEEN noon_starttime AND noon_endtime) OR
                                     (? BETWEEN evening_starttime AND evening_endtime) OR
                                     (? BETWEEN night_starttime AND night_endtime)",
                                     current_time, current_time, current_time, current_time, current_time
                                   )
                                   .pluck(:fish_id)
  
    fishes = Fish.where(id: matching_data).includes(:location)
    fishes.group_by { |fish| fish.location }
  end
end
