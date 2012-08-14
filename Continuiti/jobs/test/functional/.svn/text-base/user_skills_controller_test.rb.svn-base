require 'test_helper'

class UserSkillsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_skills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_skill" do
    assert_difference('UserSkill.count') do
      post :create, :user_skill => { }
    end

    assert_redirected_to user_skill_path(assigns(:user_skill))
  end

  test "should show user_skill" do
    get :show, :id => user_skills(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => user_skills(:one).to_param
    assert_response :success
  end

  test "should update user_skill" do
    put :update, :id => user_skills(:one).to_param, :user_skill => { }
    assert_redirected_to user_skill_path(assigns(:user_skill))
  end

  test "should destroy user_skill" do
    assert_difference('UserSkill.count', -1) do
      delete :destroy, :id => user_skills(:one).to_param
    end

    assert_redirected_to user_skills_path
  end
end
