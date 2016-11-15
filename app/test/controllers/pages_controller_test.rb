require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest

   test "about page exists" do
    about_test = root_path + '/about'
    get about_test
    assert_response :success
   end
end
