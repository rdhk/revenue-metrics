require 'test_helper'

class IvmrsControllerTest < ActionController::TestCase
  setup do
    @ivmr = ivmrs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ivmrs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ivmr" do
    assert_difference('Ivmr.count') do
      post :create, ivmr: { api_time: @ivmr.api_time, ivmr_value: @ivmr.ivmr_value }
    end

    assert_redirected_to ivmr_path(assigns(:ivmr))
  end

  test "should show ivmr" do
    get :show, id: @ivmr
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ivmr
    assert_response :success
  end

  test "should update ivmr" do
    patch :update, id: @ivmr, ivmr: { api_time: @ivmr.api_time, ivmr_value: @ivmr.ivmr_value }
    assert_redirected_to ivmr_path(assigns(:ivmr))
  end

  test "should destroy ivmr" do
    assert_difference('Ivmr.count', -1) do
      delete :destroy, id: @ivmr
    end

    assert_redirected_to ivmrs_path
  end
end
