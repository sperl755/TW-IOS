require 'test_helper'

class AwardsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:awards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create award" do
    assert_difference('Award.count') do
      post :create, :award => { }
    end

    assert_redirected_to award_path(assigns(:award))
  end

  test "should show award" do
    get :show, :id => awards(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => awards(:one).to_param
    assert_response :success
  end

  test "should update award" do
    put :update, :id => awards(:one).to_param, :award => { }
    assert_redirected_to award_path(assigns(:award))
  end

  test "should destroy award" do
    assert_difference('Award.count', -1) do
      delete :destroy, :id => awards(:one).to_param
    end

    assert_redirected_to awards_path
  end
end
