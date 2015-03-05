class RenameItemToGift < ActiveRecord::Migration
  def change
    rename_table :items, :gifts
  end
end
