class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :choice
      t.references :proposal, foreign_key: true
      t.string :ip_address

      t.timestamps
    end
  end
end
