class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :fish, null: false, foreign_key: true
      t.references :aquarium, null: false, foreign_key: true
      t.string :post_image
      t.date :shooting_date
      t.string :body

      t.timestamps
    end
  end
end
