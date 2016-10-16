class RemoveCategoryFromIdeas < ActiveRecord::Migration[5.0]
  def change
    remove_column :ideas, :category, :ideas
  end
end
