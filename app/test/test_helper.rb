ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def sign_in_as(role)
    @mock_user = users(:valid_human)
    @mock_user.role = role            # reassign role based on param
    @mock_user.password = 'password'  # "password cannot be blank", but cannot be entered into fixture..
    @mock_user.save!

    # NOTE the valid_human fixture has encrypted_password corresponding to plaintext "password"
    post user_session_path, params: {
        'user[email]' => @mock_user.email,
        'user[password]' => 'password'
      }
    # now the unit test should be authorized with given role
  end
end
