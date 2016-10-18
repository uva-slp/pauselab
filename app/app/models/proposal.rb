class Proposal < ApplicationRecord
    belongs_to :user
    has_attached_file :artist_cv
    validates_attachment :artist_cv, content_type: { content_type: ['application/pdf'] }
  #commit
end
