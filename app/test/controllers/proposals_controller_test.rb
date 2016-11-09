require 'test_helper'

class ProposalsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @proposal = proposals(:one)
    # sign_in FactoryGirl.create(:admin)
  end

  test "should get index" do
    get proposals_url
    assert_response :success
  end

  test "should get new" do
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
    get proposal_url(@proposal)
    assert_response :success
  end
  #
  test "should get edit" do
    get edit_proposal_url(@proposal)
    assert_response :success
  end
  #
  test "should also get edit" do
    get edit_proposal_url(proposals(:two))
    assert_response :success
  end
  #
  test "should update proposal" do
    patch proposal_url(@proposal), params: {
      proposal: {
        artist_fees: 100,
        project_materials: 100,
        printing: 100,
        marketing: 100,
        documentation: 100,
        volunteer: 100,
        insurance: 100,
        events: 100,
        cost: 800,
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
    assert_difference('Proposal.count', -1) do
      delete proposal_url(@proposal)
    end

    assert_redirected_to proposals_url
  end
end
