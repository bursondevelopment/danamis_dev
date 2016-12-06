require 'test_helper'

class EntornosControllerTest < ActionController::TestCase
  setup do
    @entorno = entornos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:entornos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create entorno" do
    assert_difference('Entorno.count') do
      post :create, entorno: { nombre: @entorno.nombre }
    end

    assert_redirected_to entorno_path(assigns(:entorno))
  end

  test "should show entorno" do
    get :show, id: @entorno
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @entorno
    assert_response :success
  end

  test "should update entorno" do
    put :update, id: @entorno, entorno: { nombre: @entorno.nombre }
    assert_redirected_to entorno_path(assigns(:entorno))
  end

  test "should destroy entorno" do
    assert_difference('Entorno.count', -1) do
      delete :destroy, id: @entorno
    end

    assert_redirected_to entornos_path
  end
end
