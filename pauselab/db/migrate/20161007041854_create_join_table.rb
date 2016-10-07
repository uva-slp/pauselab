class CreateJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :ideas, :categories do |t|
      # t.index [:idea_id, :category_id]
      # t.index [:category_id, :idea_id]
    end
  end
end
