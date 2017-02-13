require 'rails_helper'

RSpec.describe Vote, type: :model do
  it "is valid with proposals" do
    vote = build :vote
    expect(vote).to be_valid
  end
  it "is invalid without proposals" do
    vote = build :vote, :proposal_ids => []
    expect(vote).to_not be_valid
  end
end
