require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest

  test "index should redirect resident" do
    sign_in_as :resident
    assert_response :redirect
    follow_redirect!
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "index should redirect steerer" do
    sign_in_as :steerer
    assert_response :redirect
    follow_redirect!
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "index should redirect artist" do
    sign_in_as :artist
    assert_response :redirect
    follow_redirect!
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "index should redirect moderator" do
    sign_in_as :moderator
    assert_response :redirect
    follow_redirect!
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end


  test "index should redirect super_artist" do
    sign_in_as :super_artist
    assert_response :redirect
    follow_redirect!
    assert_response :redirect
    follow_redirect!
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
    put change_phase_path, :params => {:phase => Phase.phases[:ideas]}
    phase = Phase.new
    phase.phase = Phase.phases[:ideas]
    assert_equal Phase.get_current.phase, phase.phase
  end


end
