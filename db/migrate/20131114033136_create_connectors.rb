class CreateConnectors < ActiveRecord::Migration
  def change
    create_table :connectors do |t|
      t.integer :profile_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
