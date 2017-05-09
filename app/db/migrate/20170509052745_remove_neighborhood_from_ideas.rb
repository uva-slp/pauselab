class RemoveNeighborhoodFromIdeas < ActiveRecord::Migration[5.0]
  def change
    remove_column :ideas, :neighborhood
  end
end
