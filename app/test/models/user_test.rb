require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should not save empty user" do
    user = User.new
    assert_not user.save, "a user with a blank field should not be saved"
  end

end
