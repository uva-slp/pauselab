class AddEmailToIdeas < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :email, :string
  end
end
