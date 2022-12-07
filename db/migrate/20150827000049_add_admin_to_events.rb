class AddAdminToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :admin_id, :integer
  end
end
