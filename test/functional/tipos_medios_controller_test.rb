require 'test_helper'

class TiposMediosControllerTest < ActionController::TestCase
  setup do
    @tipo_medio = tipos_medios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipos_medios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_medio" do
    assert_difference('TipoMedio.count') do
      post :create, tipo_medio: { description: @tipo_medio.description }
    end

    assert_redirected_to tipo_medio_path(assigns(:tipo_medio))
  end

  test "should show tipo_medio" do
    get :show, id: @tipo_medio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_medio
    assert_response :success
  end

  test "should update tipo_medio" do
    put :update, id: @tipo_medio, tipo_medio: { description: @tipo_medio.description }
    assert_redirected_to tipo_medio_path(assigns(:tipo_medio))
  end

  test "should destroy tipo_medio" do
    assert_difference('TipoMedio.count', -1) do
      delete :destroy, id: @tipo_medio
    end

    assert_redirected_to tipos_medios_path
  end
end
