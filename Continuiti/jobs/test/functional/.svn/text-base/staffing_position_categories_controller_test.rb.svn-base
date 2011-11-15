require 'test_helper'

class StaffingPositionCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staffing_position_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staffing_position_category" do
    assert_difference('StaffingPositionCategory.count') do
      post :create, :staffing_position_category => { }
    end

    assert_redirected_to staffing_position_category_path(assigns(:staffing_position_category))
  end

  test "should show staffing_position_category" do
    get :show, :id => staffing_position_categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => staffing_position_categories(:one).to_param
    assert_response :success
  end

  test "should update staffing_position_category" do
    put :update, :id => staffing_position_categories(:one).to_param, :staffing_position_category => { }
    assert_redirected_to staffing_position_category_path(assigns(:staffing_position_category))
  end

  test "should destroy staffing_position_category" do
    assert_difference('StaffingPositionCategory.count', -1) do
      delete :destroy, :id => staffing_position_categories(:one).to_param
    end

    assert_redirected_to staffing_position_categories_path
  end
end
