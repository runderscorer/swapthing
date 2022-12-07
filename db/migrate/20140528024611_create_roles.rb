class CreateRoles < ActiveRecord::Migration[4.2]
  def change
    create_table :roles do |t|
      t.integer :party_id
      t.integer :user_id

      t.timestamps
    end
  end
end
