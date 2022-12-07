class AddUserIdToWishlists < ActiveRecord::Migration[4.2]
  def up
    add_column :wishlists, :user_id, :integer
    remove_column :wishlists, :membership_id
  end

  def down
    add_column :wishlists, :membership_id, :integer
    remove_column :wishlists, :user_id
  end
end
