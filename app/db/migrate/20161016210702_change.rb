class Change < ActiveRecord::Migration[5.0]
  def change
  	add_column :ideas, :category, :string
  end
end
