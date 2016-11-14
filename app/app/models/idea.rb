class Idea < ApplicationRecord

	belongs_to :category

	validates :first_name, :last_name, :phone, :email, :description, :location, :category_id, presence: true

	enum status: [:unchecked, :approved]

end
