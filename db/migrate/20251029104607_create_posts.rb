class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :kitchen_car_name, null: false
      t.text :body
      t.string :image
      t.string :place
      t.datetime :visited_at
      t.integer :rating
      t.timestamps
    end
  end
end
