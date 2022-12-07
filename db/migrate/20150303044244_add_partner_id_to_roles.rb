class AddPartnerIdToRoles < ActiveRecord::Migration[4.2]
  def change
    add_column :roles, :partner_id, :integer
  end
end
