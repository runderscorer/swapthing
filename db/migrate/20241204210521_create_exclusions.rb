class CreateExclusions < ActiveRecord::Migration[6.1]
  def change
    create_table :exclusions do |t|
      t.integer :user_id
      t.integer :excluded_user_id

      t.timestamps
    end
  end
end
