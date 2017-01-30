class CreateIterations < ActiveRecord::Migration[5.0]
  def change
    create_table :iterations do |t|
      t.date :ended
      t.integer :status

      t.timestamps
    end
  end
end
