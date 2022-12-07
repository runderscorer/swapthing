class RenamePartyToEvent < ActiveRecord::Migration[4.2]
  def change
    rename_table :parties, :events
  end
end
