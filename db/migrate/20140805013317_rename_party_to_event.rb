class RenamePartyToEvent < ActiveRecord::Migration
  def change
    rename_table :parties, :events
  end
end
