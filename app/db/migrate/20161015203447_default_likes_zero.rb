class DefaultLikesZero < ActiveRecord::Migration[5.0]
  def change
     change_column :ideas, :likes, :integer, :default => 0
  end
end
