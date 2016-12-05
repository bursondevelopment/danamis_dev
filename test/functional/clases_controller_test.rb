require 'test_helper'

class ClasesControllerTest < ActionController::TestCase
  setup do
    @clase = clases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clase" do
    assert_difference('Clase.count') do
      post :create, clase: { description: @clase.description }
    end

    assert_redirected_to clase_path(assigns(:clase))
  end

  test "should show clase" do
    get :show, id: @clase
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clase
    assert_response :success
  end

  test "should update clase" do
    put :update, id: @clase, clase: { description: @clase.description }
    assert_redirected_to clase_path(assigns(:clase))
  end

  test "should destroy clase" do
    assert_difference('Clase.count', -1) do
      delete :destroy, id: @clase
    end

    assert_redirected_to clases_path
  end
end
