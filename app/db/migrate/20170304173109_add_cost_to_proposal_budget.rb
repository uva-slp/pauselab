class AddCostToProposalBudget < ActiveRecord::Migration[5.0]
  def change
    add_column :proposal_budgets, :cost, :decimal, :default => 0
  end
end
