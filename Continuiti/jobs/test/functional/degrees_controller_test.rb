require 'test_helper'

class DegreesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:degrees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create degree" do
    assert_difference('Degree.count') do
      post :create, :degree => { }
    end

    assert_redirected_to degree_path(assigns(:degree))
  end

  test "should show degree" do
    get :show, :id => degrees(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => degrees(:one).to_param
    assert_response :success
  end

  test "should update degree" do
    put :update, :id => degrees(:one).to_param, :degree => { }
    assert_redirected_to degree_path(assigns(:degree))
  end

  test "should destroy degree" do
    assert_difference('Degree.count', -1) do
      delete :destroy, :id => degrees(:one).to_param
    end

    assert_redirected_to degrees_path
  end
end
