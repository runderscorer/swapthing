class AddEmailToInvites < ActiveRecord::Migration[4.2]
  def change
    add_column :invites, :email, :string
  end
end
