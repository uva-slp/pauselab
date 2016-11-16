require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get category index" do
    sign_in_as :moderator
    get categories_path
    assert_response :success
  end

  test "should create category" do
    sign_in_as :moderator
    get new_category_path
    assert_response :success

    assert_difference('Category.count', 1) do
      post categories_path, params: {
        category: {
          name: "New category"
          }
        }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "should update category" do
    sign_in_as :moderator
    category = categories(:one)
    assert_no_difference('Category.count') do
      put category_path(category.id), params: {
        category: {
          name: "Updated name"
          }
        }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "should remove category" do
    sign_in_as :moderator
    cat = categories(:three)
    assert_difference 'Category.count', -1 do
      delete category_path cat
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "residents can't create categories" do
    sign_in_as :resident
    get new_category_path
    assert_response :redirect, "A success would mean resident create category"
  end
  
  test "residents can't edit categories" do
    sign_in_as :resident
    cat = categories(:one)
    get edit_category_path(cat)
    assert_response :redirect, "A success would mean resident could edit categories"
  end  

  test "artist can't create categories" do
    sign_in_as :artist
    get new_category_path
    assert_response :redirect, "A success means artist can see category form"
  end
  
  
end
