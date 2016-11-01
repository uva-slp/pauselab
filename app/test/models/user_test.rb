require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should not save empty user" do
    user = User.new
    assert_not user.save, "a user with a blank field should not be saved"
  end

	test "user: valid" do
		user = users(:valid_human)
		assert user.save, user.to_yaml
		#assert: should happen
		#"" After means it didn't happen
	end

	test "user: missing first name" do
		user = users(:missing_first_name)
		assert_not user.save, "user saved: missing first name"
	end

	test "user: missing last name" do
		user = users(:missing_last_name)
		assert_not user.save, "user saved: missing last name"
	end

	test "user: missing password" do
		user = users(:missing_password)
		assert_not user.save, "user saved: missing password"
		#assert_not: should not happen
		#"" After means it did happen (which is messed up)
   	end

   	test "user: missing email" do
   		user = users(:missing_email)
   		assert_not user.save , "user saved: missing email"
   	end

   	test "user: missing phone" do
   		user = users(:missing_phone)
   		assert_not user.save, "user saved: missing phone number"
   	end

   	# MUST FIX LATER
   	# test "user: invalid phone" do
   	# 	user = users(:invalid_phone)
   	# 	assert_not user.save, "user saved: invalid phone number"
   	# end

end
