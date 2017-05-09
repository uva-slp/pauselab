class Idea < ApplicationRecord

	belongs_to :category
	belongs_to :iteration

	validates :first_name, :last_name, :phone, :email, :description, :address, :lat, :lng, :category_id, presence: true

	validates :phone, length: { is: 10 }
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

	enum status: [:unchecked, :approved]
	enum medium: [:online, :paper]

	def self.to_csv is_admin: false
		if is_admin
			self.gen_csv %w{id created_at description category_name likes lat lng address author phone email status medium}
		else
			self.gen_csv %w{id created_at description category_name likes lat lng address}
		end
	end

	after_initialize :set_default_medium, :if => :new_record?
	def set_default_medium
		self.medium ||= :online
	end

	# only keep numbers in phone before validation. credit http://stackoverflow.com/a/28621417
	before_validation :format_phone_number
	def format_phone_number
		self.phone.gsub!(/[^0-9]/, '')
	end

	def author
		if self.respond_to? :first_name and self.respond_to? :last_name
			"#{first_name} #{last_name}"
		else
			""
		end
	end

	def category_name
		category.name
	end

end
