class AddUniqueToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_index :favorites, [:post_id, :user_id], unique: true
  end
end
