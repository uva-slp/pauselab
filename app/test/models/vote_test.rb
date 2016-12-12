require 'test_helper'

class VoteTest < ActiveSupport::TestCase

   setup do
     @proposal1 = proposals(:two) # valid fixture
     @proposal2 = proposals(:three) # valid fixture
     @proposal3 = proposals(:approved) # valid fixture
     @proposal4 = proposals(:four)
     @proposal5 = proposals(:one) #invalid fixture

  end

  test "Should save vote" do
    vote = Vote.new
    vote.proposal_ids=[@proposal1.id, @proposal2.id, @proposal3.id]
    assert vote.save, "could not save vote"
  end

   test "Shouldn't save vote without three proposals" do
    vote = Vote.new
    vote.proposal_ids=[@proposal1.id, @proposal2.id]
    assert_not vote.save, "Vote saved even with only three proposals"
  end

  test "Shouldn't save vote with invalid proposal " do
    vote = Vote.new
    vote.proposal_ids=[@proposal1.id, @proposal2.id, @proposal5.id]
    assert_not vote.save, "Vote saved when one proposal was not valid"
  end



end
