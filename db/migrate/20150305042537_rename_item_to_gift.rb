class RenameItemToGift < ActiveRecord::Migration[4.2]
  def change
    rename_table :items, :gifts
  end
end
