class UpdateItemImageUrl < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :image_url, :text
  end
end
