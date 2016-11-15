class Proposal < ApplicationRecord
    belongs_to :user
    has_attached_file :artist_cv
    validates_attachment :artist_cv, content_type: { content_type: ['application/pdf'] }
    #commit
    validates :cost, :essay, :description, :artist_fees, :project_materials, :printing, :marketing, :documentation, :volunteer, :insurance, :events, presence:true

    require 'sanitize'
  	before_save :sanitize_description

  	def sanitize_description
  		Sanitize.fragment(description, Sanitize::Config::RELAXED)
  	end
end
