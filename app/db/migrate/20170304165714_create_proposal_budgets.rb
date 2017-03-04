class CreateProposalBudgets < ActiveRecord::Migration[5.0]
  def change
    create_table :proposal_budgets do |t|
      t.decimal :artist_fees, :default => 0
      t.decimal :project_materials, :default => 0
      t.decimal :printing, :default => 0
      t.decimal :marketing, :default => 0
      t.decimal :documentation, :default => 0
      t.decimal :volunteers, :default => 0
      t.decimal :insurance, :default => 0
      t.decimal :events, :default => 0
      t.integer :proposal_id
      t.timestamps
    end
  end
end
