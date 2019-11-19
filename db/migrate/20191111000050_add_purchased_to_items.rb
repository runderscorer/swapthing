class AddPurchasedToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :purchased, :boolean
  end
end
