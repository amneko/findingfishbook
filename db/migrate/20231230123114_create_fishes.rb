class CreateFishes < ActiveRecord::Migration[7.1]
  def change
    create_table :fishes do |t|
      t.string :name, null: false
      t.references :location, null: false, foreign_key: true
      t.integer :selling_price_tanuki, null: false
      t.integer :selling_price_justin, null: false
      t.string :image

      t.timestamps
    end
  end
end
