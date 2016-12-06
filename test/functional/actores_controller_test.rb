require 'test_helper'

class ActoresControllerTest < ActionController::TestCase
  setup do
    @actor = actores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:actores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create actor" do
    assert_difference('Actor.count') do
      post :create, actor: { cargo: @actor.cargo, nombres: @actor.nombres, representante_legal: @actor.representante_legal }
    end

    assert_redirected_to actor_path(assigns(:actor))
  end

  test "should show actor" do
    get :show, id: @actor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @actor
    assert_response :success
  end

  test "should update actor" do
    put :update, id: @actor, actor: { cargo: @actor.cargo, nombres: @actor.nombres, representante_legal: @actor.representante_legal }
    assert_redirected_to actor_path(assigns(:actor))
  end

  test "should destroy actor" do
    assert_difference('Actor.count', -1) do
      delete :destroy, id: @actor
    end

    assert_redirected_to actores_path
  end
end
