class AddStatusToIdeas < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :status, :string, default: 'unchecked', null: false
  end
end
