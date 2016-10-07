class CreateProposals < ActiveRecord::Migration[5.0]
  def change
    create_table :proposals do |t|
    	t.integer :cost
    	t.text :description
    	t.string :status
    	t.text :essay
    	# TODO: add more fields here on another migration 
      	t.timestamps
    end
  end
end
