class AddIndexToDbs < ActiveRecord::Migration
  def change
    add_index :connectors, :user_id
    add_index :connectors, :movie_id
  end
end
