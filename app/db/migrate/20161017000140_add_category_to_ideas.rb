class AddCategoryToIdeas < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :category_id, :integer
  end
end
