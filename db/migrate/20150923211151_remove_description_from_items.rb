class RemoveDescriptionFromItems < ActiveRecord::Migration
  def up
    remove_column :items, :description
  end

  def down
    add_column :items, :description
  end
end
