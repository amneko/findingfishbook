require "csv"

# # 都道府県のテストデータ作成
# CSV.foreach('db/csv/prefecture.csv', headers: true) do |row|
#   Prefecture.create(
#     name: row['name']
#   )
# end

# # 水族館のテストデータ作成
# CSV.foreach('db/csv/aquarium.csv', headers: true) do |row|
#   Aquarium.create(
#     name: row['name'],
#     prefecture_id: row['prefecture_id'],
#     address: row['address'],
#     website: row['website']
#   )
# end

# # 出現場所のテストデータ作成
# CSV.foreach('db/csv/location.csv', headers: true) do |row|
#   Location.create(
#     name: row['name']
#   )
# end

# # 魚のテストデータ作成
CSV.foreach('db/csv/fish.csv', headers: true) do |row|
  Fish.create(
    name: row['name'],
    location_id: row['location_id'],
    selling_price_tanuki: row['selling_price_tanuki'],
    selling_price_justin: row['selling_price_justin'],
    image: row['image']
  )
end

# # 出現情報のテストデータ作成
# CSV.foreach('db/csv/north_appearance.csv', headers: true) do |row|
#   NorthAppearance.create(
#     fish_id: row['fish_id'],
#     north_month: row['north_month'],
#     latenight_starttime: row['latenight_starttime'],
#     latenight_endtime: row['latenight_endtime'],
#     morning_starttime: row['morning_starttime'],
#     morning_endtime: row['morning_endtime'],
#     noon_starttime: row['noon_starttime'],
#     noon_endtime: row['noon_endtime'],
#     evening_starttime: row['evening_starttime'],
#     evening_endtime: row['evening_endtime'],
#     night_starttime: row['night_starttime'],
#     night_endtime: row['night_endtime']
#   )
# end