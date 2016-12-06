require 'test_helper'

class MedioOrganizacionesControllerTest < ActionController::TestCase
  setup do
    @medio_organizacion = medio_organizaciones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:medio_organizaciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create medio_organizacion" do
    assert_difference('MedioOrganizacion.count') do
      post :create, medio_organizacion: { propio: @medio_organizacion.propio }
    end

    assert_redirected_to medio_organizacion_path(assigns(:medio_organizacion))
  end

  test "should show medio_organizacion" do
    get :show, id: @medio_organizacion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @medio_organizacion
    assert_response :success
  end

  test "should update medio_organizacion" do
    put :update, id: @medio_organizacion, medio_organizacion: { propio: @medio_organizacion.propio }
    assert_redirected_to medio_organizacion_path(assigns(:medio_organizacion))
  end

  test "should destroy medio_organizacion" do
    assert_difference('MedioOrganizacion.count', -1) do
      delete :destroy, id: @medio_organizacion
    end

    assert_redirected_to medio_organizaciones_path
  end
end
