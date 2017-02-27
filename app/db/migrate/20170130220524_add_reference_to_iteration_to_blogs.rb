class AddReferenceToIterationToBlogs < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :iteration_id, :integer
  end
end
