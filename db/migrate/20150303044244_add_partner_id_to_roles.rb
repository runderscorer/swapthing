class AddPartnerIdToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :partner_id, :integer
  end
end
