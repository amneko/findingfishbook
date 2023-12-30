require "csv"

# # 都道府県のテストデータ作成
# CSV.foreach('db/csv/prefecture.csv', headers: true) do |row|
#   Prefecture.create(
#     name: row['name']
#   )
# end

# 水族館のテストデータ作成
CSV.foreach('db/csv/aquarium.csv', headers: true) do |row|
  Aquarium.create(
    name: row['name'],
    prefecture_id: row['prefecture_id'],
    address: row['address'],
    website: row['website']
  )
end
