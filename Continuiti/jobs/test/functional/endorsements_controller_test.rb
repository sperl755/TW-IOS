require 'test_helper'

class EndorsementsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:endorsements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create endorsement" do
    assert_difference('Endorsement.count') do
      post :create, :endorsement => { }
    end

    assert_redirected_to endorsement_path(assigns(:endorsement))
  end

  test "should show endorsement" do
    get :show, :id => endorsements(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => endorsements(:one).to_param
    assert_response :success
  end

  test "should update endorsement" do
    put :update, :id => endorsements(:one).to_param, :endorsement => { }
    assert_redirected_to endorsement_path(assigns(:endorsement))
  end

  test "should destroy endorsement" do
    assert_difference('Endorsement.count', -1) do
      delete :destroy, :id => endorsements(:one).to_param
    end

    assert_redirected_to endorsements_path
  end
end
