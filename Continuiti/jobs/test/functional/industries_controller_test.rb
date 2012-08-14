require 'test_helper'

class IndustriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:industries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create industry" do
    assert_difference('Industry.count') do
      post :create, :industry => { }
    end

    assert_redirected_to industry_path(assigns(:industry))
  end

  test "should show industry" do
    get :show, :id => industries(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => industries(:one).to_param
    assert_response :success
  end

  test "should update industry" do
    put :update, :id => industries(:one).to_param, :industry => { }
    assert_redirected_to industry_path(assigns(:industry))
  end

  test "should destroy industry" do
    assert_difference('Industry.count', -1) do
      delete :destroy, :id => industries(:one).to_param
    end

    assert_redirected_to industries_path
  end
end
