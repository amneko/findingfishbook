class CreateAquariums < ActiveRecord::Migration[7.1]
  def change
    create_table :aquariums do |t|
      t.string :name, null: false
      t.references :prefecture, foreign_key: true, null: false
      t.string :address, null: false
      t.string :website

      t.timestamps
    end
  end
end
