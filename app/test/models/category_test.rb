require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  
  test "valid category" do
    category = categories(:one)
    assert category.save, "could not save category"
  end
  
  test "category: NULL" do
   category = Category.new
  assert_not category.save, "NULL category saved"
  end

end
