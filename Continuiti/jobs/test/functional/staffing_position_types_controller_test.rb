require 'test_helper'

class StaffingPositionTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staffing_position_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staffing_position_type" do
    assert_difference('StaffingPositionType.count') do
      post :create, :staffing_position_type => { }
    end

    assert_redirected_to staffing_position_type_path(assigns(:staffing_position_type))
  end

  test "should show staffing_position_type" do
    get :show, :id => staffing_position_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => staffing_position_types(:one).to_param
    assert_response :success
  end

  test "should update staffing_position_type" do
    put :update, :id => staffing_position_types(:one).to_param, :staffing_position_type => { }
    assert_redirected_to staffing_position_type_path(assigns(:staffing_position_type))
  end

  test "should destroy staffing_position_type" do
    assert_difference('StaffingPositionType.count', -1) do
      delete :destroy, :id => staffing_position_types(:one).to_param
    end

    assert_redirected_to staffing_position_types_path
  end
end
