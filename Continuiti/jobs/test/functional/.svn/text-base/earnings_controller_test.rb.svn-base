require 'test_helper'

class EarningsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:earnings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create earning" do
    assert_difference('Earning.count') do
      post :create, :earning => { }
    end

    assert_redirected_to earning_path(assigns(:earning))
  end

  test "should show earning" do
    get :show, :id => earnings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => earnings(:one).to_param
    assert_response :success
  end

  test "should update earning" do
    put :update, :id => earnings(:one).to_param, :earning => { }
    assert_redirected_to earning_path(assigns(:earning))
  end

  test "should destroy earning" do
    assert_difference('Earning.count', -1) do
      delete :destroy, :id => earnings(:one).to_param
    end

    assert_redirected_to earnings_path
  end
end
