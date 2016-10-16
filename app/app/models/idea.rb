class Idea < ApplicationRecord
	validates_presence_of :first_name, :on => :create
	validates_presence_of :last_name, :on => :create
	validates_presence_of :phone, :on => :create
	validates_presence_of :description, :on => :create

	scope :status, -> (status) { where status: status }
end
