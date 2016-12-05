require 'test_helper'

class ToldasControllerTest < ActionController::TestCase
  setup do
    @tolda = toldas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:toldas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tolda" do
    assert_difference('Tolda.count') do
      post :create, tolda: { description: @tolda.description }
    end

    assert_redirected_to tolda_path(assigns(:tolda))
  end

  test "should show tolda" do
    get :show, id: @tolda
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tolda
    assert_response :success
  end

  test "should update tolda" do
    put :update, id: @tolda, tolda: { description: @tolda.description }
    assert_redirected_to tolda_path(assigns(:tolda))
  end

  test "should destroy tolda" do
    assert_difference('Tolda.count', -1) do
      delete :destroy, id: @tolda
    end

    assert_redirected_to toldas_path
  end
end
