require 'test_helper'

class ProposalsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @proposal = proposals(:one)
    # make the proposal's owner the user used for sign in
    @proposal.user = users(:valid_human)
    @proposal.save!
  end

  test "should get index" do
    sign_in_as :resident
    get proposals_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as :artist
    get new_proposal_url
    assert_response :success
  end
  #
  # test "should create proposal" do
  #   assert_difference('Proposal.count') do
  #     post proposals_url, params: { proposal: {
  #         description: "I will creating something",
  #         cost: 100,
  #         essay: "shortest essay ever",
  #         user: 0
  #        } }
  #   end
  #
  #   assert_redirected_to proposal_url(Proposal.last)
  # end

  test "should show proposal" do
    sign_in_as :resident
    get proposal_url(@proposal)
    assert_response :success
  end
  #
  test "should get edit" do
    sign_in_as :artist
    get edit_proposal_url(@proposal)
    assert_response :success
  end
  #
  test "should update proposal" do
    sign_in_as :artist
    patch proposal_url(@proposal), params: {
      proposal: {
        cost: 100,
        description: 'colorful bench',
        essay: 'this will help everyone',
        status: 'unchecked',
        user: :oscar
       }
     }
    assert_redirected_to proposal_url(@proposal)
  end
  #
  test "should destroy proposal" do
    sign_in_as :artist
    assert_difference('Proposal.count', -1) do
      delete proposal_url(@proposal)
    end

    assert_redirected_to proposals_url
  end
end
