class AddDefaultToStatusInIteration < ActiveRecord::Migration[5.0]
  def change
    change_column :iterations, :status, :integer, :default => 0
  end
end
