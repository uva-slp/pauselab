class Idea < ApplicationRecord

	validates_presence_of :name, :on => :create
	validates_presence_of :phone, :on => :create
	validates_presence_of :description, :on => :create

	scope :status, -> (status) { where status: status }

end
