require 'test_helper'

class SlpMailerTest < ActionMailer::TestCase

  test "should send mail" do
    email = SlpMailer.email_self
    assert_emails 1 do
      email.deliver_now
    end
  end

end
