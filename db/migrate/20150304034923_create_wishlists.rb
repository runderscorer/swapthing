class CreateWishlists < ActiveRecord::Migration[4.2]
  def change
    create_table :wishlists do |t|
      t.integer  :partnership_id
    end
  end
end
