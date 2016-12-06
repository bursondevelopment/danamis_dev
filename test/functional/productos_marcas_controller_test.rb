require 'test_helper'

class ProductosMarcasControllerTest < ActionController::TestCase
  setup do
    @producto_marca = productos_marcas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:productos_marcas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create producto_marca" do
    assert_difference('ProductoMarca.count') do
      post :create, producto_marca: {  }
    end

    assert_redirected_to producto_marca_path(assigns(:producto_marca))
  end

  test "should show producto_marca" do
    get :show, id: @producto_marca
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @producto_marca
    assert_response :success
  end

  test "should update producto_marca" do
    put :update, id: @producto_marca, producto_marca: {  }
    assert_redirected_to producto_marca_path(assigns(:producto_marca))
  end

  test "should destroy producto_marca" do
    assert_difference('ProductoMarca.count', -1) do
      delete :destroy, id: @producto_marca
    end

    assert_redirected_to productos_marcas_path
  end
end
