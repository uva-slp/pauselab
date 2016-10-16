class Idea < ApplicationRecord

	# validates_presence_of :first_name, :on => :create
	# validates_presence_of :phone, :on => :create
	# validates_presence_of :description, :on => :create

	validates :first_name, :last_name, :phone, :email, :description, presence: true

	scope :status, -> (status) { where status: status }
end
