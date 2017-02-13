class AddIconToCategory < ActiveRecord::Migration[5.0]
  def up
    add_attachment :categories, :icon
  end
  def down
    remove_attachment :categories, :icon
  end
end
