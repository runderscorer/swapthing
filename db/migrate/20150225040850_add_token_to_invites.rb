class AddTokenToInvites < ActiveRecord::Migration[4.2]
  def change
    add_column :invites, :token, :string
  end
end
