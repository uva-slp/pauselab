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
end
