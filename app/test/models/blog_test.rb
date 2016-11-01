require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  
  test "valid blog post" do
    blog = blogs(:valid_post)
    assert blog.save, "could not save blog"
  end
  
  test "blog: missing title" do
    blog = blogs(:missing_title)
    assert_not blog.save, "blog saved without title"
  end

  test "blog: missing body" do
    blog = blogs(:missing_body)
    assert_not blog.save, "blog saved without body"
  end
  
end
