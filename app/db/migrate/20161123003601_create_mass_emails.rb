class CreateMassEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :mass_emails do |t|
      t.string :to
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
