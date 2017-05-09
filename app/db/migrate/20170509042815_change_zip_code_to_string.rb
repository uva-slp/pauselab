class ChangeZipCodeToString < ActiveRecord::Migration[5.0]
  def change
    change_column :votes, :zip_code, :string
  end
end
