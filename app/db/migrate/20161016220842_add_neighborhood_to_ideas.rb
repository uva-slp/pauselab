class AddNeighborhoodToIdeas < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :neighborhood, :string
  end
end
