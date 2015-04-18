class AddNameToWishlists < ActiveRecord::Migration
  def change
    add_column :wishlists, :name, :string
  end
end
