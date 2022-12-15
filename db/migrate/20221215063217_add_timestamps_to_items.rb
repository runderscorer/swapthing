class AddTimestampsToItems < ActiveRecord::Migration[6.1]
  def change
    add_timestamps :items, default: DateTime.now
    change_column_default :items, :created_at, from: DateTime.now, to: nil
    change_column_default :items, :updated_at, from: DateTime.now, to: nil
  end
end
