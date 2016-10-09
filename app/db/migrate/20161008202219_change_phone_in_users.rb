class ChangePhoneInUsers < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :phone, :string, null: true
  end
end
