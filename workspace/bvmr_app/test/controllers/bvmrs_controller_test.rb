require 'test_helper'

class BvmrsControllerTest < ActionController::TestCase
  setup do
    @bvmr = bvmrs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bvmrs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bvmr" do
    assert_difference('Bvmr.count') do
      post :create, bvmr: { todays_date: @bvmr.todays_date, total_value: @bvmr.total_value }
    end

    assert_redirected_to bvmr_path(assigns(:bvmr))
  end

  test "should show bvmr" do
    get :show, id: @bvmr
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bvmr
    assert_response :success
  end

  test "should update bvmr" do
    patch :update, id: @bvmr, bvmr: { todays_date: @bvmr.todays_date, total_value: @bvmr.total_value }
    assert_redirected_to bvmr_path(assigns(:bvmr))
  end

  test "should destroy bvmr" do
    assert_difference('Bvmr.count', -1) do
      delete :destroy, id: @bvmr
    end

    assert_redirected_to bvmrs_path
  end
end
