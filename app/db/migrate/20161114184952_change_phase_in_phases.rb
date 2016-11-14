class ChangePhaseInPhases < ActiveRecord::Migration[5.0]
  def change
    change_column :phases, :phase, :integer, default: 0
  end
end
