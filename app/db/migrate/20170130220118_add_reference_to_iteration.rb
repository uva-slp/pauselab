class AddReferenceToIteration < ActiveRecord::Migration[5.0]
  def change
    add_column :votes, :iteration_id, :integer
    add_column :ideas, :iteration_id, :integer
    add_column :proposals, :iteration_id, :integer
  end
end
