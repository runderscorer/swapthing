class AddImageToItems < ActiveRecord::Migration[4.2]
  def change
    add_attachment :items, :image
  end
end
