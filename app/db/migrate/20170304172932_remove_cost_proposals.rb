class RemoveCostProposals < ActiveRecord::Migration[5.0]
  def change
    remove_column :proposals, :cost
  end
end
