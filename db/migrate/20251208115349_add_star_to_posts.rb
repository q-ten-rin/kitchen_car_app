class AddStarToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :star, :integer
  end
end
