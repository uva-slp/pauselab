class AddUserInfoToVotes < ActiveRecord::Migration[5.0]
  def change
    add_column :votes, :first_name, :string
    add_column :votes, :last_name, :string
    add_column :votes, :phone, :string
    add_column :votes, :email, :string
  end
end
