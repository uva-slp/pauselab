require 'rails_helper'

RSpec.describe ProposalComment, type: :model do
  it "is valid with all fields" do
    proposal_comment = build :proposal_comment
    expect(proposal_comment).to be_valid
  end

  it "is invalid without body" do
    proposal_comment = build :proposal_comment, :body => ''
    expect(proposal_comment).to_not be_valid
  end
end
