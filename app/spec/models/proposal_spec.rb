require 'rails_helper'

RSpec.describe Proposal, type: :model do

  it "is valid with all fields" do
    proposal = build :proposal
    expect(proposal).to be_valid
  end

  it "is invalid without essay" do
    proposal = build :proposal, :essay => ''
    expect(proposal).to_not be_valid
  end

  it "is invalid without description" do
    proposal = build :proposal, :description => ''
    expect(proposal).to_not be_valid
  end

  it "is invalid without title" do
    proposal = build :proposal, :title => ''
    expect(proposal).to_not be_valid
  end

  it "can retrieve its number of votes" do
    proposal = create :proposal_votes
    expect(proposal.number_of_votes).to eq(3)
  end

  it "returns the authors full name" do
    user = create :artist, :first_name => 'John', :last_name =>'Smith'
    proposal = create :proposal, :user =>user
    expect(proposal.author_name).to eq('John Smith')
  end

  it "returns the cost" do
    proposal = create :proposal
    expect(proposal.total_cost).to eq(proposal.proposal_budget.cost)
  end

  it "returns (empty) comment history" do
    proposal = create :proposal
    expect(proposal.comment_history_to_s).to eq('')
  end

  it "returns (nonempty) comment history" do
    proposal = create :proposal
    proposal_comment = create :proposal_comment, :proposal => proposal
    expect(proposal.comment_history_to_s).to_not eq('')
  end

end
