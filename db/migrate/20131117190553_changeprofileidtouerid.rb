class Changeprofileidtouerid < ActiveRecord::Migration
  def change
    rename_column :connectors, :profile_id, :user_id
  end
end
