class RenameColumnInWishlists < ActiveRecord::Migration
  def change
    rename_column :wishlists, :partnership_id, :membership_id
  end
end
