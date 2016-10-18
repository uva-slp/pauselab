class ProposalsStatusDefault < ActiveRecord::Migration[5.0]
  def change
    change_column :proposals, :status, :string, :default => 'unchecked'
  end
end
