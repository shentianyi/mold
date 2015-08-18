require 'test_helper'

class KnifeSwitchRecordsControllerTest < ActionController::TestCase
  setup do
    @knife_switch_record = knife_switch_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:knife_switch_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create knife_switch_record" do
    assert_difference('KnifeSwitchRecord.count') do
      post :create, knife_switch_record: { broken_life: @knife_switch_record.broken_life, damage_define: @knife_switch_record.damage_define, damage_life: @knife_switch_record.damage_life, knife_kind: @knife_switch_record.knife_kind, knife_supplier: @knife_switch_record.knife_supplier, knife_type: @knife_switch_record.knife_type, m_qty: @knife_switch_record.m_qty, machine_id: @knife_switch_record.machine_id, maintainman: @knife_switch_record.maintainman, mould_id: @knife_switch_record.mould_id, press_num: @knife_switch_record.press_num, problem: @knife_switch_record.problem, project_id: @knife_switch_record.project_id, state: @knife_switch_record.state, total_life: @knife_switch_record.total_life }
    end

    assert_redirected_to knife_switch_record_path(assigns(:knife_switch_record))
  end

  test "should show knife_switch_record" do
    get :show, id: @knife_switch_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @knife_switch_record
    assert_response :success
  end

  test "should update knife_switch_record" do
    patch :update, id: @knife_switch_record, knife_switch_record: { broken_life: @knife_switch_record.broken_life, damage_define: @knife_switch_record.damage_define, damage_life: @knife_switch_record.damage_life, knife_kind: @knife_switch_record.knife_kind, knife_supplier: @knife_switch_record.knife_supplier, knife_type: @knife_switch_record.knife_type, m_qty: @knife_switch_record.m_qty, machine_id: @knife_switch_record.machine_id, maintainman: @knife_switch_record.maintainman, mould_id: @knife_switch_record.mould_id, press_num: @knife_switch_record.press_num, problem: @knife_switch_record.problem, project_id: @knife_switch_record.project_id, state: @knife_switch_record.state, total_life: @knife_switch_record.total_life }
    assert_redirected_to knife_switch_record_path(assigns(:knife_switch_record))
  end

  test "should destroy knife_switch_record" do
    assert_difference('KnifeSwitchRecord.count', -1) do
      delete :destroy, id: @knife_switch_record
    end

    assert_redirected_to knife_switch_records_path
  end
end
