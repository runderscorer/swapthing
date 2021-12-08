class CreateAddress < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :zip
      t.string :state
      t.references :user

      t.timestamps
    end
  end
end
