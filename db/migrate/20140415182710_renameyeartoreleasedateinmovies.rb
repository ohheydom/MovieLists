class Renameyeartoreleasedateinmovies < ActiveRecord::Migration
  def up
    rename_column :movies, :year, :release_date
  end

  def down
    rename_column :movies, :release_date, :year
  end
end
