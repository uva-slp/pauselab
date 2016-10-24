require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get category index" do
    get categories_path
    assert_response :success
  end

  test "should create category" do
    get new_category_path
    assert_response :success

    assert_difference('Category.count', 1) do
      post categories_path, {category: {name: "New category"}}
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "should update category" do
    category = categories(:one)
    assert_no_difference('Category.count') do
      put category_path(category.id), {category: {name: "Updated name"}}
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
end
