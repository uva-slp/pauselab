class MakePhoneNotNull < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :phone, :string, null: false
  end
end
