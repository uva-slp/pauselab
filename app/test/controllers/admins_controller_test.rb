require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest

  test "should get admin index" do
    sign_in_as :admin
    get admin_overview_path
    assert_response :success
  end

  test "should get users index" do
    sign_in_as :admin
    get list_users_path
    assert_response :success
  end

  test "should get edit phase" do
    sign_in_as :admin
    get admin_edit_phase_path
    assert_response :success
  end

  test "should change phase" do
    sign_in_as :admin
    put change_phase_path, :params => {:phase => 0}
    phase = Phase.new
    phase.phase = 0
    assert_equal Phase.get_current.phase, phase.phase
  end


  # test "should change phase" do
  #   sign_in_as :admin




end
