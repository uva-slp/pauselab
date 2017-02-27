class AddTitleToProposals < ActiveRecord::Migration[5.0]
  def change
    add_column :proposals, :title, :string, :limit => 40
  end
end
