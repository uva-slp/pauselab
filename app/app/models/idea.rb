class Idea < ApplicationRecord

	belongs_to :category

	validates :first_name, :last_name, :phone, :email, :description, :location, :category_id, presence: true

	scope :status, -> (status) { where status: status }

         def is_approved
          if status == "approved"
            return true
          else
            return false
          end
        end

end
