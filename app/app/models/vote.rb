class Vote < ApplicationRecord
  has_and_belongs_to_many :proposals
  belongs_to :iteration

  validates :first_name, :last_name, :phone, :email, :street, :city, :state, :zip_code, presence: true
  validates :phone, length: { is: 10 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  # only keep numbers in phone before validation. credit http://stackoverflow.com/a/28621417
	before_validation :format_phone_number
	def format_phone_number
    unless self.phone.nil?
      self.phone.gsub!(/[^0-9]/, '')
    end
	end

  validate :validate_proposals
  def validate_proposals
    errors.add(:proposals, :proposal_count) if proposals.size < 3
  end

  def author
    "#{first_name} #{last_name}"
  end

  def address
    "#{street}, #{city}, #{state}, #{zip_code}"
  end

end
