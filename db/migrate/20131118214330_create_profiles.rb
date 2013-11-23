class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :username
      t.string :favorite_movie
      t.string :favorite_genre
      t.integer :user_id

      t.timestamps
    end
  end
end
