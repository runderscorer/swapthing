class CreateMemberships < ActiveRecord::Migration[4.2]
  def change
    create_table :memberships do |t|
      t.integer  :event_id
      t.integer  :user_id
      t.integer  :wishlist_id
    end
  end
end
