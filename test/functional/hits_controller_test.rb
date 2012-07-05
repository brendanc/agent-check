require 'test_helper'

class HitsControllerTest < ActionController::TestCase
  setup do
    @hit = hits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hit" do
    assert_difference('Hit.count') do
      post :create, hit: { agent: @hit.agent, code: @hit.code, ip: @hit.ip, referrer: @hit.referrer }
    end

    assert_redirected_to hit_path(assigns(:hit))
  end

  test "should show hit" do
    get :show, id: @hit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hit
    assert_response :success
  end

  test "should update hit" do
    put :update, id: @hit, hit: { agent: @hit.agent, code: @hit.code, ip: @hit.ip, referrer: @hit.referrer }
    assert_redirected_to hit_path(assigns(:hit))
  end

  test "should destroy hit" do
    assert_difference('Hit.count', -1) do
      delete :destroy, id: @hit
    end

    assert_redirected_to hits_path
  end
end
