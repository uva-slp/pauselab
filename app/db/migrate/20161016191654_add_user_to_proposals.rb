class AddUserToProposals < ActiveRecord::Migration[5.0]
  def change
    add_column :proposals, :user_id, :integer
    add_index  :proposals, :user_id
  end
end
