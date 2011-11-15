require 'test_helper'

class JobtypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobtypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jobtype" do
    assert_difference('Jobtype.count') do
      post :create, :jobtype => { }
    end

    assert_redirected_to jobtype_path(assigns(:jobtype))
  end

  test "should show jobtype" do
    get :show, :id => jobtypes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => jobtypes(:one).to_param
    assert_response :success
  end

  test "should update jobtype" do
    put :update, :id => jobtypes(:one).to_param, :jobtype => { }
    assert_redirected_to jobtype_path(assigns(:jobtype))
  end

  test "should destroy jobtype" do
    assert_difference('Jobtype.count', -1) do
      delete :destroy, :id => jobtypes(:one).to_param
    end

    assert_redirected_to jobtypes_path
  end
end
