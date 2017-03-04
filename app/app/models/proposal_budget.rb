class ProposalBudget < ApplicationRecord

  before_save :find_total

  belongs_to :proposal_budget

  validates :artist_fees, :project_materials, :printing, :marketing, :documentation, :volunteers, :insurance, :events, presence: true

  private
    def find_total
      self.cost =
        self.artist_fees +
        self.project_materials +
        self.printing +
        self.marketing +
        self.documentation +
        self.volunteers +
        self.insurance +
        self.events
    end

end
