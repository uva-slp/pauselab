class AddBudgetFieldsToProposals < ActiveRecord::Migration[5.0]
  def change
      add_column :proposals, :artist_fees, :decimal
      add_column :proposals, :project_materials, :decimal
      add_column :proposals, :printing, :decimal
      add_column :proposals, :marketing, :decimal
      add_column :proposals, :documentation, :decimal
      add_column :proposals, :volunteer, :decimal
      add_column :proposals, :insurance, :decimal
      add_column :proposals, :events, :decimal
  end
end
