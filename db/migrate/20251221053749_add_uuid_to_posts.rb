class AddUuidToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :uuid, :string
    add_index  :posts, :uuid, unique: true
  end
end
