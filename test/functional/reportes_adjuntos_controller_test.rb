require 'test_helper'

class ReportesAdjuntosControllerTest < ActionController::TestCase
  setup do
    @reporte_adjunto = reportes_adjuntos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reportes_adjuntos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reporte_adjunto" do
    assert_difference('ReporteAdjunto.count') do
      post :create, reporte_adjunto: {  }
    end

    assert_redirected_to reporte_adjunto_path(assigns(:reporte_adjunto))
  end

  test "should show reporte_adjunto" do
    get :show, id: @reporte_adjunto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reporte_adjunto
    assert_response :success
  end

  test "should update reporte_adjunto" do
    put :update, id: @reporte_adjunto, reporte_adjunto: {  }
    assert_redirected_to reporte_adjunto_path(assigns(:reporte_adjunto))
  end

  test "should destroy reporte_adjunto" do
    assert_difference('ReporteAdjunto.count', -1) do
      delete :destroy, id: @reporte_adjunto
    end

    assert_redirected_to reportes_adjuntos_path
  end
end
