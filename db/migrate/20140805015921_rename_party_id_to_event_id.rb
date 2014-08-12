class RenamePartyIdToEventId < ActiveRecord::Migration
  def change
    rename_column :roles, :party_id, :event_id
  end
end
