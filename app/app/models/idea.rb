class Idea < ApplicationRecord

	belongs_to :category
	belongs_to :iteration

	validates :first_name, :last_name, :phone, :email, :description, :address, :lat, :lng, :category_id, presence: true

	validates :phone, length: { is: 10, wrong_length: 'phone numbers can only be 10 characters long' }
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

	enum status: [:unchecked, :approved]

	def self.to_csv
		self.gen_csv %w{id created_at description category_name likes lat lng address author phone email status}
	end

	def author
		"#{first_name} #{last_name}"
	end

	def category_name
		category.name
	end

end
