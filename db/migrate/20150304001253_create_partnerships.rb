class CreatePartnerships < ActiveRecord::Migration
  def change
    create_table :partnerships do |t|
      t.integer  :giver_id
      t.integer  :getter_id
      t.integer  :event_id
    end
  end
end
