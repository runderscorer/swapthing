class CreateInvites < ActiveRecord::Migration[4.2]
  def change
    create_table :invites do |t|
      t.string    :sender_id
      t.string    :recipient_id
      t.datetime  :accepted_at
      t.string    :event_id
      t.string    :created_at
    end
  end
end
