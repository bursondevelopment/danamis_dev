require 'test_helper'

class EspecializacionesMedioControllerTest < ActionController::TestCase
  setup do
    @especializacion_medio = especializaciones_medio(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:especializaciones_medio)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create especializacion_medio" do
    assert_difference('EspecializacionMedio.count') do
      post :create, especializacion_medio: {  }
    end

    assert_redirected_to especializacion_medio_path(assigns(:especializacion_medio))
  end

  test "should show especializacion_medio" do
    get :show, id: @especializacion_medio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @especializacion_medio
    assert_response :success
  end

  test "should update especializacion_medio" do
    put :update, id: @especializacion_medio, especializacion_medio: {  }
    assert_redirected_to especializacion_medio_path(assigns(:especializacion_medio))
  end

  test "should destroy especializacion_medio" do
    assert_difference('EspecializacionMedio.count', -1) do
      delete :destroy, id: @especializacion_medio
    end

    assert_redirected_to especializaciones_medio_path
  end
end
