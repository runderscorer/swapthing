class AddPartnershipIdToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :partnership_id, :integer
  end
end
