require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should get admin index" do
    get admin_path
    assert_response :success
  end

end
