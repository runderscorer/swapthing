class AddPartnershipIdToMemberships < ActiveRecord::Migration[4.2]
  def change
    add_column :memberships, :partnership_id, :integer
  end
end
