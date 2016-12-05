require 'test_helper'

class InternasControllerTest < ActionController::TestCase
  setup do
    @interna = internas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:internas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create interna" do
    assert_difference('Interna.count') do
      post :create, interna: { description: @interna.description }
    end

    assert_redirected_to interna_path(assigns(:interna))
  end

  test "should show interna" do
    get :show, id: @interna
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @interna
    assert_response :success
  end

  test "should update interna" do
    put :update, id: @interna, interna: { description: @interna.description }
    assert_redirected_to interna_path(assigns(:interna))
  end

  test "should destroy interna" do
    assert_difference('Interna.count', -1) do
      delete :destroy, id: @interna
    end

    assert_redirected_to internas_path
  end
end
