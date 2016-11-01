require 'test_helper'

class ProposalTest < ActiveSupport::TestCase
  test "should save proposal" do
    proposal = Proposal.new
    proposal.cost = 100
    proposal.description = "colorful bench"
    proposal.essay = "this will help everyone"
    proposal.status = "unchecked"
    assert proposal.save, "could not save proposal"
  end

   test "status should be uncheked" do
     proposal = Proposal.new
     assert_equal "unchecked", proposal.status, "Status should be unchecked"
   end

   test "Tests the pressence of cost" do
     proposal = Proposal.new
     proposal.description = "new sign"
     proposal.essay = "cheerful environment"
     proposal.status = "unchecked"
     assert_not proposal.save, "proposal saved without cost"
   end

    test "Tests the pressence of description" do
     proposal = Proposal.new
     proposal.cost = 123
     proposal.essay = "cheerful environment"
     proposal.status = "unchecked"
     assert_not proposal.save, "proposal saved without description"
    end

    test "Tests the pressence of essay" do
     proposal = Proposal.new
     proposal.description = "new sign"
     proposal.cost = 123
     proposal.status = "unchecked"
     assert_not proposal.save, "proposal saved without essay"
   end
end
