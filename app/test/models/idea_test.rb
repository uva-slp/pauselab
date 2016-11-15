require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test "should save" do
    idea = Idea.new
    idea.first_name = "John"
    idea.last_name = "Doe"
    idea.phone = "5555555555"
    idea.email = "john.doe@example.com"
    idea.description = "something cool"
    idea.location = "somewhere"
    idea.category = categories(:two)
    assert idea.save, "could not save idea"
  end

  test "should validate description presence" do
    idea = Idea.new
    idea.first_name = "John"
    idea.last_name = "Doe"
    idea.phone = "5555555555"
    idea.email = "john.doe@example.com"
    idea.location = "somewhere"
    idea.category = categories(:two)
    assert_not idea.save, "saved idea without description"
  end

  test "should validate first name presence" do
    idea = ideas(:missing_first_name)
    assert_not idea.save, "saved idea without first name"
  end

  test "should validate last name presence" do
    idea = ideas(:missing_last_name)
    assert_not idea.save, "saved idea without last name presence"
  end

  test "should validate phone presence" do
    idea = ideas(:missing_phone)
    assert_not idea.save, "saved idea without phone presence"
  end

  test "should validate email presence" do
    idea = ideas(:missing_email)
    assert_not idea.save, "saved idea without email presence"
  end

end
