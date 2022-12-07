class RemoveDescriptionFromItems < ActiveRecord::Migration[4.2]
  def up
    remove_column :items, :description
  end

  def down
    add_column :items, :description
  end
end
