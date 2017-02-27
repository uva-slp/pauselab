require 'test_helper'

class ProposalCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @proposal = proposals(:two)
  end

  test "should create new comment" do
    sign_in_as :steerer
    get new_proposal_proposal_comment_path(@proposal.id)
    assert_response :success

    assert_difference('ProposalComment.count', 1) do
      post proposal_proposal_comments_path, params: {
        proposal_comment: {
          body: 'new comment!',
          proposal: :approved,
          user: :valid_human
        }
      }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "should not be authorized to make comment" do
    sign_in_as :resident
    get new_proposal_proposal_comment_path(@proposal.id)
    assert_response :redirect
  end

  test "should update comment" do
    sign_in_as :steerer
    comment = proposal_comments(:two) # belongs to signed in steerer
    assert_no_difference('ProposalComment.count') do
      put proposal_proposal_comment_path(@proposal.id, comment.id), params: {
        proposal_comment: {
          body: 'updated text'
        }
      }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success

    comment.reload
    assert_equal 'updated text', comment.body
  end

  test "should remove comment" do
    sign_in_as :steerer
    comment = proposal_comments(:two) # belongs to signed in steerer
    assert_difference('ProposalComment.count', -1) do
      delete proposal_proposal_comment_path(@proposal.id, comment.id)
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "should read comments" do
    sign_in_as :steerer
    get proposal_proposal_comments_path(@proposal.id)
    assert_response :success
  end

  test "should not be authorized to read comments" do
    sign_in_as :resident
    get proposal_proposal_comments_path(@proposal.id)
    assert_response :redirect
  end
end
