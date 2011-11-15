require 'test_helper'

class ReferralsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:referrals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create referral" do
    assert_difference('Referral.count') do
      post :create, :referral => { }
    end

    assert_redirected_to referral_path(assigns(:referral))
  end

  test "should show referral" do
    get :show, :id => referrals(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => referrals(:one).to_param
    assert_response :success
  end

  test "should update referral" do
    put :update, :id => referrals(:one).to_param, :referral => { }
    assert_redirected_to referral_path(assigns(:referral))
  end

  test "should destroy referral" do
    assert_difference('Referral.count', -1) do
      delete :destroy, :id => referrals(:one).to_param
    end

    assert_redirected_to referrals_path
  end
end
