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

  it "returns the authors name" do
    vote = create :vote, :first_name=>'John', :last_name=>'Smith'
    expect(vote.author).to eq('John Smith')
  end

  it "returns the vote address" do
    vote = create :vote, :street=>'101 East St', :city=>'Charlottesville', :state=>'VA', :zip_code=>'12345'
    expect(vote.address).to eq('101 East St, Charlottesville, VA, 12345')
  end

end
