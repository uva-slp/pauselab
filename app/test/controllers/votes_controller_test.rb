require 'test_helper'

class VotesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
   setup do
     @proposal1 = proposals(:two) # valid fixture
     @proposal2 = proposals(:three) # valid fixture
     @proposal3 = proposals(:approved) # valid fixture
     @proposal4 = proposals(:four)
     @proposal5 = proposals(:one) #invalid fixture

  end

  
   test "should get index" do
    sign_in_as :resident
    get votes_url
    assert_response :success
   end

   test "Create a vote with valid proposals" do
    sign_in_as :resident
    assert_difference('Vote.count', 1) do
      post votes_url, params: {
        vote: {
          proposal_ids:[@proposal1.id, @proposal2.id, @proposal3.id]
         }
       }
    end
    assert_redirected_to root_path
  end

end
