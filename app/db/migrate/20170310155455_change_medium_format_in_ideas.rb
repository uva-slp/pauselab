class ChangeMediumFormatInIdeas < ActiveRecord::Migration[5.0]
  def change
    remove_column :ideas, :medium
    add_column :ideas, :medium, :integer, :default => 0 # unchecked
  end
end
