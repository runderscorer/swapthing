class AddNameToWishlists < ActiveRecord::Migration[4.2]
  def change
    add_column :wishlists, :name, :string
  end
end
