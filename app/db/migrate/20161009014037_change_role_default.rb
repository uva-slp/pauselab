class ChangeRoleDefault < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :role, :string, default: 'artist'
  end
end
