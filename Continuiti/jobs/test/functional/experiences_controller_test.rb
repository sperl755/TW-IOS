require 'test_helper'

class ExperiencesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:experiences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create experience" do
    assert_difference('Experience.count') do
      post :create, :experience => { }
    end

    assert_redirected_to experience_path(assigns(:experience))
  end

  test "should show experience" do
    get :show, :id => experiences(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => experiences(:one).to_param
    assert_response :success
  end

  test "should update experience" do
    put :update, :id => experiences(:one).to_param, :experience => { }
    assert_redirected_to experience_path(assigns(:experience))
  end

  test "should destroy experience" do
    assert_difference('Experience.count', -1) do
      delete :destroy, :id => experiences(:one).to_param
    end

    assert_redirected_to experiences_path
  end
end
