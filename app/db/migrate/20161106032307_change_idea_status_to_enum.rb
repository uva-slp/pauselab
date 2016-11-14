class ChangeIdeaStatusToEnum < ActiveRecord::Migration[5.0]
  def change
    remove_column :ideas, :status
    add_column :ideas, :status, :integer, :default => 0 # unchecked
  end
end
