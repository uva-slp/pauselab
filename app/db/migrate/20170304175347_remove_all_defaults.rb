class RemoveAllDefaults < ActiveRecord::Migration[5.0]
  def change
    change_column :proposal_budgets, :artist_fees, :decimal, default: nil
    change_column :proposal_budgets, :project_materials, :decimal, default: nil
    change_column :proposal_budgets, :printing, :decimal, default: nil
    change_column :proposal_budgets, :marketing, :decimal, default: nil
    change_column :proposal_budgets, :documentation, :decimal, default: nil
    change_column :proposal_budgets, :volunteers, :decimal, default: nil
    change_column :proposal_budgets, :insurance, :decimal, default: nil
    change_column :proposal_budgets, :events, :decimal, default: nil
    change_column :proposal_budgets, :cost, :decimal, default: nil
  end
end
