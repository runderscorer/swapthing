class ChangeItemUrlToText < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :url, :text
  end
end
