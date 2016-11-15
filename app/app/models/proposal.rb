class Proposal < ApplicationRecord
    belongs_to :user
    has_many :vote
    has_attached_file :artist_cv
    validates_attachment :artist_cv, content_type: { content_type: ['application/pdf'] }
    #commit
    validates :cost, :essay, :description, presence:true
  

      
end
