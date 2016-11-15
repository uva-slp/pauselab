require 'test_helper'

class ProposalsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @proposal = proposals(:two) # valid fixture
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
  test "should create proposal" do
    sign_in_as :artist
    assert_difference('Proposal.count', 1) do
      post proposals_url, params: {
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
          description: "I am creating something",
          essay: "shortest essay ever",
          user: :valid_human
         }
       }
    end
    assert_redirected_to proposals_url
  end

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
        user: :valid_human
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
    
   test "residents can't look at  proposal form" do
    sign_in_as :resident
    get new_proposal_url
    assert_response :redirect, "If success resident created proposal"
   end

    test "residents can't edit proposals" do
    sign_in_as :resident
    get edit_proposal_url(@proposal)
    assert_response :redirect, "If success resident can edit proposal"
    end

    
   
end
