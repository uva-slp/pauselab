class AddEnumRoleToUser < ActiveRecord::Migration[5.0]
  def change
      remove_column :users, :role
      add_column :users, :role, :integer, :default => 2 # artist
  end
  """
  def up
      change_table :users do |t|
          t.change :role, :integer, :default => 2
      end
  end
  def down
      change_table :users do |t|
          t.change :role, :string
      end
  end
  """
end
