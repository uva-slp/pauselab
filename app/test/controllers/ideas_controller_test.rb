require 'test_helper'

class IdeasControllerTest < ActionDispatch::IntegrationTest
    test "should get idea index" do
        get ideas_path
        assert_response :success
    end
    test "should create a new idea" do
        sign_in_as :resident
        get new_idea_path
        assert_response :success

        assert_difference('Idea.count', 1) do
            post ideas_path, params: {
              idea:{
                first_name: "John",
                last_name: "Smith",
                email: "johnsmith@gmail.com",
                phone: "1234567890",
                address: "Charlottesville",
                lat: 1.00,
                lng: 2.00,
                category_id: categories(:one).id,
                description: "An idea."
                }
              }
        end
        assert_response :redirect
        follow_redirect!
        assert_response :success
    end
    test "should fail to create new idea" do
        sign_in_as :resident
        get new_idea_path
        assert_response :success

        assert_no_difference('Idea.count') do
            post ideas_path, params: {
              idea: {
                last_name: "Smith",
                email: "johnsmith@gmail.com",
                phone: "1234567890",
                category_id: "1",
                description: "An idea."
                }
              }
        end
    end
    test "should update an idea" do
        sign_in_as :moderator
        idea = ideas(:one)
        assert_no_difference('Idea.count') do
            put idea_path(idea.id), params: {
              idea: {
                first_name: "James"
                }
              }
        end
        assert_response :redirect
        follow_redirect!
        # assert_response :success
    end
    test "should delete an idea" do
        sign_in_as :moderator
        idea = ideas(:one)
        assert_difference('Idea.count',-1) do
            delete idea_path(idea.id)
        end
        assert_response :redirect
        follow_redirect!
        assert_response :success
    end

    test "create cookie for likes" do
        sign_in_as :resident
        #cookies['likes'] = nil
        assert_equal cookies['likes'], nil
        get idea_like_path(12)
        assert_response :redirect
        follow_redirect!
        assert_response :success
        assert_equal cookies['likes'], '[12]'
    end

    test "add like to cookie" do
        sign_in_as :resident
        cookies['likes'] = '[12]'
        get idea_like_path(14)
        assert_response :redirect
        follow_redirect!
        assert_response :success
        assert_equal cookies['likes'], '[12,14]'
    end

    test "remove like from cookie" do
        sign_in_as :resident
        cookies['likes'] = '[12,14]'
        get idea_like_path(14)
        assert_response :redirect
        follow_redirect!
        assert_response :success
        assert_equal cookies['likes'], '[12]'
    end

end
