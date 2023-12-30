class CreateNorthAppearances < ActiveRecord::Migration[7.1]
  def change
    create_table :north_appearances do |t|
      t.references :fish, null: false, foreign_key: true
      t.string :north_month, null: false
      t.string :latenight_starttime
      t.string :latenight_endtime
      t.string :morning_starttime
      t.string :morning_endtime
      t.string :noon_starttime
      t.string :noon_endtime
      t.string :evening_starttime
      t.string :evening_endtime
      t.string :night_starttime
      t.string :night_endtime

      t.timestamps
    end
  end
end
