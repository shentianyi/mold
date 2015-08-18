require 'test_helper'

class KnifeSwitchSlicesControllerTest < ActionController::TestCase
  setup do
    @knife_switch_slice = knife_switch_slices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:knife_switch_slices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create knife_switch_slice" do
    assert_difference('KnifeSwitchSlice.count') do
      post :create, knife_switch_slice: { image_after: @knife_switch_slice.image_after, image_before: @knife_switch_slice.image_before, knife_type1: @knife_switch_slice.knife_type1, knife_type2: @knife_switch_slice.knife_type2, mould_id: @knife_switch_slice.mould_id, project_id: @knife_switch_slice.project_id, terminal_leoni_id: @knife_switch_slice.terminal_leoni_id, wire_type: @knife_switch_slice.wire_type }
    end

    assert_redirected_to knife_switch_slice_path(assigns(:knife_switch_slice))
  end

  test "should show knife_switch_slice" do
    get :show, id: @knife_switch_slice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @knife_switch_slice
    assert_response :success
  end

  test "should update knife_switch_slice" do
    patch :update, id: @knife_switch_slice, knife_switch_slice: { image_after: @knife_switch_slice.image_after, image_before: @knife_switch_slice.image_before, knife_type1: @knife_switch_slice.knife_type1, knife_type2: @knife_switch_slice.knife_type2, mould_id: @knife_switch_slice.mould_id, project_id: @knife_switch_slice.project_id, terminal_leoni_id: @knife_switch_slice.terminal_leoni_id, wire_type: @knife_switch_slice.wire_type }
    assert_redirected_to knife_switch_slice_path(assigns(:knife_switch_slice))
  end

  test "should destroy knife_switch_slice" do
    assert_difference('KnifeSwitchSlice.count', -1) do
      delete :destroy, id: @knife_switch_slice
    end

    assert_redirected_to knife_switch_slices_path
  end
end
