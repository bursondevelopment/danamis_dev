require 'test_helper'

class TipoEspecializacionesControllerTest < ActionController::TestCase
  setup do
    @tipo_especializacion = tipo_especializaciones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_especializaciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_especializacion" do
    assert_difference('TipoEspecializacion.count') do
      post :create, tipo_especializacion: { description: @tipo_especializacion.description }
    end

    assert_redirected_to tipo_especializacion_path(assigns(:tipo_especializacion))
  end

  test "should show tipo_especializacion" do
    get :show, id: @tipo_especializacion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_especializacion
    assert_response :success
  end

  test "should update tipo_especializacion" do
    put :update, id: @tipo_especializacion, tipo_especializacion: { description: @tipo_especializacion.description }
    assert_redirected_to tipo_especializacion_path(assigns(:tipo_especializacion))
  end

  test "should destroy tipo_especializacion" do
    assert_difference('TipoEspecializacion.count', -1) do
      delete :destroy, id: @tipo_especializacion
    end

    assert_redirected_to tipo_especializaciones_path
  end
end
