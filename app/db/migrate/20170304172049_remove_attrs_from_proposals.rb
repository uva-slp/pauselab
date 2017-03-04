class RemoveAttrsFromProposals < ActiveRecord::Migration[5.0]
  def change
    remove_column :proposals, :artist_fees
    remove_column :proposals, :project_materials
    remove_column :proposals, :marketing
    remove_column :proposals, :documentation
    remove_column :proposals, :volunteer
    remove_column :proposals, :insurance
    remove_column :proposals, :events
  end
end
