require 'test_helper'

class ClavesControllerTest < ActionController::TestCase
  setup do
    @clave = claves(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:claves)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clave" do
    assert_difference('Clave.count') do
      post :create, clave: { incluyente: @clave.incluyente, valor: @clave.valor }
    end

    assert_redirected_to clave_path(assigns(:clave))
  end

  test "should show clave" do
    get :show, id: @clave
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clave
    assert_response :success
  end

  test "should update clave" do
    put :update, id: @clave, clave: { incluyente: @clave.incluyente, valor: @clave.valor }
    assert_redirected_to clave_path(assigns(:clave))
  end

  test "should destroy clave" do
    assert_difference('Clave.count', -1) do
      delete :destroy, id: @clave
    end

    assert_redirected_to claves_path
  end
end
