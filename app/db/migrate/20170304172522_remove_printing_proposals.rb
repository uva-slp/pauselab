class RemovePrintingProposals < ActiveRecord::Migration[5.0]
  def change
    remove_column :proposals, :printing
  end
end
