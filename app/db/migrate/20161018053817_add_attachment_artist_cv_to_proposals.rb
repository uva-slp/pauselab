class AddAttachmentArtistCvToProposals < ActiveRecord::Migration
  def self.up
    change_table :proposals do |t|
      t.attachment :artist_cv
    end
  end

  def self.down
    remove_attachment :proposals, :artist_cv
  end
end
