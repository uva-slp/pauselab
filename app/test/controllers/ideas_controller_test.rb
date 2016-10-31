require 'test_helper'

class IdeasControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
    test "should get idea index" do
        get ideas_path
        assert_response :success
    end
    test "should create a new idea" do
        get new_idea_path
        assert_response :success
        
        assert_difference('Idea.count', 1) do
            post ideas_path, {idea: {first_name: "John", last_name: "Smith", email: "johnsmith@gmail.com", phone: "1234567890", location: "Charlottesville", category_id: "1", description: "An idea."}}
        end
        assert_response :redirect
        follow_redirect!
        assert_response :success
    end
    test "should fail to create new idea" do
        get new_idea_path
        assert_response :success
        
        assert_no_difference('Idea.count') do
            post ideas_path, {idea: {last_name: "Smith", email: "johnsmith@gmail.com", phone: "1234567890", location: "Charlottesville", category_id: "1", description: "An idea."}}
        end
    end
    test "should update an idea" do
        idea = ideas(:one)
        assert_no_difference('Idea.count') do
            put idea_path(idea.id), {idea: {first_name: "James"}}
        end
        assert_response :redirect
        follow_redirect!
        assert_response :success
    end
    test "should delete an idea" do
        idea = ideas(:two)
        assert_difference('Idea.count',-1) do
            delete idea_path(idea.id)
        end
        assert_response :redirect
        follow_redirect!
        assert_response :success
    end
end
