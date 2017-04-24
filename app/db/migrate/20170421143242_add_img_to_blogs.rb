class AddImgToBlogs < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :key_img, :string
  end
end
