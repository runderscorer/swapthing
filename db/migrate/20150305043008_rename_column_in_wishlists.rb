class RenameColumnInWishlists < ActiveRecord::Migration[4.2]
  def change
    rename_column :wishlists, :partnership_id, :membership_id
  end
end
