require 'test_helper'

class ProposalCommentTest < ActiveSupport::TestCase

  test "should save" do
    comment = ProposalComment.new
    comment.proposal_id = proposals(:one).id
    comment.user_id = users(:oscar).id
    comment.body = 'sample body'
    assert comment.save, "could not save comment"
  end

  test "should not save: missing user" do
    comment = ProposalComment.new
    comment.proposal_id = proposals(:one).id
    comment.body = 'sample body'
    assert_not comment.save, "could not save comment"
  end

  test "should save: missing body" do
    comment = ProposalComment.new
    comment.proposal_id = proposals(:one).id
    comment.user_id = users(:oscar).id
    assert comment.save, "could not save comment"
  end
end
