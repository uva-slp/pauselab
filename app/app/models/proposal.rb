class Proposal < ApplicationRecord
    belongs_to :user
    has_many :votes, :dependent => :delete_all
    has_attached_file :artist_cv
    validates_attachment :artist_cv, content_type: { content_type: ['application/pdf'] }
    #commit
    validates :cost, :essay, :description, :artist_fees, :project_materials, :printing, :marketing, :documentation, :volunteer, :insurance, :events, presence:true

end
