class Removeprofilestable < ActiveRecord::Migration
  def change
  drop_table(:profiles)
  end
end