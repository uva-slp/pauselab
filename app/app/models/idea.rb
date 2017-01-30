class Idea < ApplicationRecord

	belongs_to :category

	validates :first_name, :last_name, :phone, :email, :description, :address, :lat, :lng, :category_id, presence: true

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
