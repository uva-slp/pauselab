class ChangeProposalStatusToEnum < ActiveRecord::Migration[5.0]
  def change
    remove_column :proposals, :status
    add_column :proposals, :status, :integer, :default => 0 # unchecked
  end
end
