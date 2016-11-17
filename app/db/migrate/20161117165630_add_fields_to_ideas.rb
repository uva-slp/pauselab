class AddFieldsToIdeas < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :lat, :decimal, {:precision=>10, :scale=>6}
    add_column :ideas, :lng, :decimal, {:precision=>10, :scale=>6}
    add_column :ideas, :address, :string
  end
end
