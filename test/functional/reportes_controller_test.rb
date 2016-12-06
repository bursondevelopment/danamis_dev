require 'test_helper'

class ReportesControllerTest < ActionController::TestCase
  setup do
    @reporte = reportes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reportes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reporte" do
    assert_difference('Reporte.count') do
      post :create, reporte: { argumento: @reporte.argumento, fecha: @reporte.fecha, titulo: @reporte.titulo }
    end

    assert_redirected_to reporte_path(assigns(:reporte))
  end

  test "should show reporte" do
    get :show, id: @reporte
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reporte
    assert_response :success
  end

  test "should update reporte" do
    put :update, id: @reporte, reporte: { argumento: @reporte.argumento, fecha: @reporte.fecha, titulo: @reporte.titulo }
    assert_redirected_to reporte_path(assigns(:reporte))
  end

  test "should destroy reporte" do
    assert_difference('Reporte.count', -1) do
      delete :destroy, id: @reporte
    end

    assert_redirected_to reportes_path
  end
end
