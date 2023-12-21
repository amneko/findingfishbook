class SorceryCore < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email,            null: false, index: { unique: true }
      t.string :crypted_password
      t.string :salt
      t.string :name, null: false
      t.string :icon
      t.string :like_fish
      t.string :like_aquarium
      t.integer :role, default: 0, null: false

      t.timestamps                null: false
    end
  end
end
