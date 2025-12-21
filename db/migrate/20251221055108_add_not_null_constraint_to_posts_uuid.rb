class AddNotNullConstraintToPostsUuid < ActiveRecord::Migration[7.2]
  def change
    change_column_null :posts, :uuid, false
  end
end
