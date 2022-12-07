class CreateItems < ActiveRecord::Migration[4.2]
  def change
    create_table :items do |t|
      t.integer  :wishlist_id
      t.string   :name
      t.string   :description
      t.integer  :price
      t.string   :notes
      t.string   :url
    end
  end
end
