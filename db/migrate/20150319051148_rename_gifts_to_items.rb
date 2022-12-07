class RenameGiftsToItems < ActiveRecord::Migration[4.2]
  def change
    rename_table :gifts, :items
  end
end
