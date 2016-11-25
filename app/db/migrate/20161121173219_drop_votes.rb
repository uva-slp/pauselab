class DropVotes < ActiveRecord::Migration[5.0]
  def up
    drop_table :votes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
    
end
