class RenameGiftsToItems < ActiveRecord::Migration
  def change
    rename_table :gifts, :items
  end
end
