require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test "should save" do
    idea = Idea.new
    idea.first_name = "John"
    idea.last_name = "Doe"
    idea.phone = "5555555555"
    idea.email = "john.doe@example.com"
    idea.description = "something cool"
    idea.category = categories(:two)
    assert idea.save, "could not save idea"
  end

  test "should validate description presence" do
    idea = Idea.new
    idea.first_name = "John"
    idea.last_name = "Doe"
    idea.phone = "5555555555"
    idea.email = "john.doe@example.com"
    idea.category = categories(:two)
    assert_not idea.save, "saved idea without description"
  end
end
