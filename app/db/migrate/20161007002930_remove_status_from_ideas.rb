class RemoveStatusFromIdeas < ActiveRecord::Migration[5.0]
  def change
  	remove_column :ideas, :status, :string
  end
end
