class AddEnumTitleToLandingpage < ActiveRecord::Migration[5.0]
  def change
      remove_column :landingpages, :title
      add_column :landingpages, :title, :integer, :default => 0
  end
end
