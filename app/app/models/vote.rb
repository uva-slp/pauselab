class Vote < ApplicationRecord
  has_and_belongs_to_many :proposals
  validate :validate_proposals
  belongs_to :iteration

	#validates :first_name, :last_name, :phone, :email
  #validates :phone, length: { is: 10, wrong_length: 'phone numbers can only be 10 characters long' }
  #validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }


  def validate_proposals
    errors.add(:proposals, "need to select three proposals") if proposals.size < 3
  end

  def author
    "#{first_name} #{last_name}"
  end

end
