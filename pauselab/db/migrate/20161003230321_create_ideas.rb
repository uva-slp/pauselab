class CreateIdeas < ActiveRecord::Migration[5.0]

  def change

    create_table :ideas do |t|
    	t.string :first_name
    	t.string :last_name
    	t.integer :phone
    	t.text :description
    	t.string :location
    	t.string :category
    	t.string :status
    	t.integer :likes
     	t.timestamps
    end

  end

end
