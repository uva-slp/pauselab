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
    proposal.number_of_votes.should == 3
  end

  #it "can get its artist's name" do
  #  proposal = create :proposal_admin
  #  proposal.author_name.should = 'John Smith'
  #end

end
