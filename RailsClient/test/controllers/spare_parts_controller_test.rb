require 'test_helper'

class SparePartsControllerTest < ActionController::TestCase
  setup do
    @spare_part = spare_parts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spare_parts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spare_part" do
    assert_difference('SparePart.count') do
      post :create, spare_part: { broken_state: @spare_part.broken_state, machine_id: @spare_part.machine_id, maintainman: @spare_part.maintainman, mould_id: @spare_part.mould_id, outbound_id: @spare_part.outbound_id, project_id: @spare_part.project_id, qty: @spare_part.qty, record_date: @spare_part.record_date, spare_kind: @spare_part.spare_kind, spare_type: @spare_part.spare_type }
    end

    assert_redirected_to spare_part_path(assigns(:spare_part))
  end

  test "should show spare_part" do
    get :show, id: @spare_part
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @spare_part
    assert_response :success
  end

  test "should update spare_part" do
    patch :update, id: @spare_part, spare_part: { broken_state: @spare_part.broken_state, machine_id: @spare_part.machine_id, maintainman: @spare_part.maintainman, mould_id: @spare_part.mould_id, outbound_id: @spare_part.outbound_id, project_id: @spare_part.project_id, qty: @spare_part.qty, record_date: @spare_part.record_date, spare_kind: @spare_part.spare_kind, spare_type: @spare_part.spare_type }
    assert_redirected_to spare_part_path(assigns(:spare_part))
  end

  test "should destroy spare_part" do
    assert_difference('SparePart.count', -1) do
      delete :destroy, id: @spare_part
    end

    assert_redirected_to spare_parts_path
  end
end
