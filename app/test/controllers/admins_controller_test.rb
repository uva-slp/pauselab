require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get admin index" do
    sign_in_as :admin
    get admin_path
    assert_response :success
  end

end
