class CreateParties < ActiveRecord::Migration[4.2]
  def change
    create_table :parties do |t|
      t.string :name
      t.datetime :date
      t.text :description
      t.integer :max_spend
      t.integer :participants

      t.timestamps
    end
  end
end
