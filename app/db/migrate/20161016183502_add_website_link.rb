class AddWebsiteLink < ActiveRecord::Migration[5.0]
  def change
    add_column :proposals, :website_link, :string
  end
end
