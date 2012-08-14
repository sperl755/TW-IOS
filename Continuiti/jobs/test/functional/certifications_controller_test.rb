require 'test_helper'

class CertificationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:certifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create certification" do
    assert_difference('Certification.count') do
      post :create, :certification => { }
    end

    assert_redirected_to certification_path(assigns(:certification))
  end

  test "should show certification" do
    get :show, :id => certifications(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => certifications(:one).to_param
    assert_response :success
  end

  test "should update certification" do
    put :update, :id => certifications(:one).to_param, :certification => { }
    assert_redirected_to certification_path(assigns(:certification))
  end

  test "should destroy certification" do
    assert_difference('Certification.count', -1) do
      delete :destroy, :id => certifications(:one).to_param
    end

    assert_redirected_to certifications_path
  end
end
