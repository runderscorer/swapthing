class RenamePartyIdToEventId < ActiveRecord::Migration[4.2]
  def change
    rename_column :roles, :party_id, :event_id
  end
end
