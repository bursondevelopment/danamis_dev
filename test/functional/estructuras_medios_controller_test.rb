require 'test_helper'

class EstructurasMediosControllerTest < ActionController::TestCase
  setup do
    @estructura_medio = estructuras_medios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:estructuras_medios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create estructura_medio" do
    assert_difference('EstructuraMedio.count') do
      post :create, estructura_medio: { articulo: @estructura_medio.articulo, contenido: @estructura_medio.contenido, fecha: @estructura_medio.fecha, imagen: @estructura_medio.imagen, titulo: @estructura_medio.titulo, url: @estructura_medio.url }
    end

    assert_redirected_to estructura_medio_path(assigns(:estructura_medio))
  end

  test "should show estructura_medio" do
    get :show, id: @estructura_medio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @estructura_medio
    assert_response :success
  end

  test "should update estructura_medio" do
    put :update, id: @estructura_medio, estructura_medio: { articulo: @estructura_medio.articulo, contenido: @estructura_medio.contenido, fecha: @estructura_medio.fecha, imagen: @estructura_medio.imagen, titulo: @estructura_medio.titulo, url: @estructura_medio.url }
    assert_redirected_to estructura_medio_path(assigns(:estructura_medio))
  end

  test "should destroy estructura_medio" do
    assert_difference('EstructuraMedio.count', -1) do
      delete :destroy, id: @estructura_medio
    end

    assert_redirected_to estructuras_medios_path
  end
end
