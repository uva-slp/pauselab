class AddCategoryIdToProposals < ActiveRecord::Migration[5.0]
  def change
    add_column :proposals, :category_id, :integer
  end
end
