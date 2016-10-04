class ChangePhoneFormat < ActiveRecord::Migration[5.0]
  def change
  	change_column :ideas, :phone, :string
  end
end
