require 'test_helper'

class UsersAwardsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users_awards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create users_award" do
    assert_difference('UsersAward.count') do
      post :create, :users_award => { }
    end

    assert_redirected_to users_award_path(assigns(:users_award))
  end

  test "should show users_award" do
    get :show, :id => users_awards(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => users_awards(:one).to_param
    assert_response :success
  end

  test "should update users_award" do
    put :update, :id => users_awards(:one).to_param, :users_award => { }
    assert_redirected_to users_award_path(assigns(:users_award))
  end

  test "should destroy users_award" do
    assert_difference('UsersAward.count', -1) do
      delete :destroy, :id => users_awards(:one).to_param
    end

    assert_redirected_to users_awards_path
  end
end
