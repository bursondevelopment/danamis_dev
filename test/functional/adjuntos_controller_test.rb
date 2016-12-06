require 'test_helper'

class AdjuntosControllerTest < ActionController::TestCase
  setup do
    @adjunto = adjuntos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adjuntos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adjunto" do
    assert_difference('Adjunto.count') do
      post :create, adjunto: { autor: @adjunto.autor, fecha: @adjunto.fecha, sumario: @adjunto.sumario, titulo: @adjunto.titulo }
    end

    assert_redirected_to adjunto_path(assigns(:adjunto))
  end

  test "should show adjunto" do
    get :show, id: @adjunto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @adjunto
    assert_response :success
  end

  test "should update adjunto" do
    put :update, id: @adjunto, adjunto: { autor: @adjunto.autor, fecha: @adjunto.fecha, sumario: @adjunto.sumario, titulo: @adjunto.titulo }
    assert_redirected_to adjunto_path(assigns(:adjunto))
  end

  test "should destroy adjunto" do
    assert_difference('Adjunto.count', -1) do
      delete :destroy, id: @adjunto
    end

    assert_redirected_to adjuntos_path
  end
end
