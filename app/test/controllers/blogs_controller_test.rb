require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest
  test "should create a blog post" do
    sign_in_as :artist  # TODO only artists who have passed voting stage
    get new_blog_path
    assert_response :success

    assert_difference 'Blog.count', 1 do
      post blogs_path, params: {
        blog: {
          title: "cool stuff",
          body: "is happening."
        }
      }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "should read blog posts" do
    sign_in_as :resident
    get blogs_path
    assert_response :success
  end

  test "should update a blog post, by owner" do
    sign_in_as :artist
    post = blogs(:valid_post)
    # post belongs to valid_human, who is signed in
    assert_no_difference 'Blog.count' do
      put blog_path(post.id), params: {
        blog: {
          title: "The Title",
          body: "changed!"
        }
      }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success

    # check that changes were committed
    post.reload
    assert_equal "The Title", post.title
    assert_equal "changed!", post.body
  end

  test "should not update a blog post, by non-owner" do
    sign_in_as :artist
    post = blogs(:post_by_other)
    # post does not belong to the signed in user
    assert_no_difference 'Blog.count' do
      put blog_path(post.id), params: {
        blog: {
          title: "The Title",
          body: "changed!"
        }
      }
    end
    # redirect still happens
    assert_response :redirect
    follow_redirect!
    assert_response :success

    # but the parameters should not have changed
    post.reload
    assert_not_equal "The Title", post.title
    assert_not_equal "changed!", post.body
  end

  test "should delete a blog post, by moderator" do
    sign_in_as :moderator
    post = blogs(:valid_post)
    assert_difference 'Blog.count', -1 do
      delete blog_path post
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
end
