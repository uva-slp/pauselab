class Idea < ApplicationRecord

	belongs_to :category

	validates :first_name, :last_name, :phone, :email, :description, :address, :lat, :lng, :category_id, presence: true

	enum status: [:unchecked, :approved]

	def author
		"#{first_name} #{last_name}"
	end

end
