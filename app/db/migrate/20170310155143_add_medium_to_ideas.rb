class AddMediumToIdeas < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :medium, :string, default: 'online', null: false
  end
end
