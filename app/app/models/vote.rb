class Vote < ApplicationRecord
  has_and_belongs_to_many :proposals
  validate :validate_proposals
  belongs_to :iteration

  def validate_proposals
    errors.add(:proposals, "need to select three proposals") if proposals.size < 3
  end

end
