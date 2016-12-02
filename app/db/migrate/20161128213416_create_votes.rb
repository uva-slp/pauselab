class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    # this migration is out of band, so do conditional check
    if ActiveRecord::Base.connection.table_exists? :votes
      drop_table :votes
    end
    create_table :votes do |t|
      t.timestamps
    end
  end
end
