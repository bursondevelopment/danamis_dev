require 'test_helper'

class ExternasControllerTest < ActionController::TestCase
  setup do
    @externa = externas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:externas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create externa" do
    assert_difference('Externa.count') do
      post :create, externa: { description: @externa.description }
    end

    assert_redirected_to externa_path(assigns(:externa))
  end

  test "should show externa" do
    get :show, id: @externa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @externa
    assert_response :success
  end

  test "should update externa" do
    put :update, id: @externa, externa: { description: @externa.description }
    assert_redirected_to externa_path(assigns(:externa))
  end

  test "should destroy externa" do
    assert_difference('Externa.count', -1) do
      delete :destroy, id: @externa
    end

    assert_redirected_to externas_path
  end
end
