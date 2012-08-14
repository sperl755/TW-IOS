require 'test_helper'

class AwardUsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:award_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create award_user" do
    assert_difference('AwardUser.count') do
      post :create, :award_user => { }
    end

    assert_redirected_to award_user_path(assigns(:award_user))
  end

  test "should show award_user" do
    get :show, :id => award_users(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => award_users(:one).to_param
    assert_response :success
  end

  test "should update award_user" do
    put :update, :id => award_users(:one).to_param, :award_user => { }
    assert_redirected_to award_user_path(assigns(:award_user))
  end

  test "should destroy award_user" do
    assert_difference('AwardUser.count', -1) do
      delete :destroy, :id => award_users(:one).to_param
    end

    assert_redirected_to award_users_path
  end
end
