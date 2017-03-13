require 'rails_helper'

RSpec.describe ProposalBudget, type: :model do

  it "is valid with all fields" do
    budget = build :proposal_budget
    expect(budget).to be_valid
  end

  it "is not valid with one of fields missing" do
    budget = build :proposal_budget, :artist_fees => ''
    expect(budget).to_not be_valid
  end

  it "saves the total cost" do
    budget = create :proposal_budget
    cost =
      budget.artist_fees +
      budget.project_materials +
      budget.printing +
      budget.marketing +
      budget.documentation +
      budget.volunteers +
      budget.insurance +
      budget.events
    expect(budget.cost).to eq cost
  end

end
