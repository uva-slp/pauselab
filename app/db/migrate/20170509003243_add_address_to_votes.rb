class AddAddressToVotes < ActiveRecord::Migration[5.0]
  def change
    add_column :votes, :street, :string
    add_column :votes, :city, :string
    add_column :votes, :state, :string
    add_column :votes, :zip_code, :integer
  end
end
