class ProposalComment < ApplicationRecord
  belongs_to :proposal
  belongs_to :user

  validates :body, presence: true
end
