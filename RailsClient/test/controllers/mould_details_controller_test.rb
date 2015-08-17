require 'test_helper'

class MouldDetailsControllerTest < ActionController::TestCase
  setup do
    @mould_detail = mould_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mould_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mould_detail" do
    assert_difference('MouldDetail.count') do
      post :create, mould_detail: { mould_id: @mould_detail.mould_id, mould_supplier: @mould_detail.mould_supplier, mould_type: @mould_detail.mould_type, position: @mould_detail.position, stopwater: @mould_detail.stopwater, terminal_leoni_no: @mould_detail.terminal_leoni_no, terminal_supplier: @mould_detail.terminal_supplier, use_range: @mould_detail.use_range, wire_cross: @mould_detail.wire_cross, wire_type: @mould_detail.wire_type }
    end

    assert_redirected_to mould_detail_path(assigns(:mould_detail))
  end

  test "should show mould_detail" do
    get :show, id: @mould_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mould_detail
    assert_response :success
  end

  test "should update mould_detail" do
    patch :update, id: @mould_detail, mould_detail: { mould_id: @mould_detail.mould_id, mould_supplier: @mould_detail.mould_supplier, mould_type: @mould_detail.mould_type, position: @mould_detail.position, stopwater: @mould_detail.stopwater, terminal_leoni_no: @mould_detail.terminal_leoni_no, terminal_supplier: @mould_detail.terminal_supplier, use_range: @mould_detail.use_range, wire_cross: @mould_detail.wire_cross, wire_type: @mould_detail.wire_type }
    assert_redirected_to mould_detail_path(assigns(:mould_detail))
  end

  test "should destroy mould_detail" do
    assert_difference('MouldDetail.count', -1) do
      delete :destroy, id: @mould_detail
    end

    assert_redirected_to mould_details_path
  end
end
