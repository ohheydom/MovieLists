class Addindextomovieid < ActiveRecord::Migration
  def change
    add_index :movies, :id
  end
end
