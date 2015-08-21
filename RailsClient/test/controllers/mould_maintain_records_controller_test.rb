require 'test_helper'

class MouldMaintainRecordsControllerTest < ActionController::TestCase
  setup do
    @mould_maintain_record = mould_maintain_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mould_maintain_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mould_maintain_record" do
    assert_difference('MouldMaintainRecord.count') do
      post :create, mould_maintain_record: { count: @mould_maintain_record.count, mould_id: @mould_maintain_record.mould_id, plan_date: @mould_maintain_record.plan_date, real_date: @mould_maintain_record.real_date }
    end

    assert_redirected_to mould_maintain_record_path(assigns(:mould_maintain_record))
  end

  test "should show mould_maintain_record" do
    get :show, id: @mould_maintain_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mould_maintain_record
    assert_response :success
  end

  test "should update mould_maintain_record" do
    patch :update, id: @mould_maintain_record, mould_maintain_record: { count: @mould_maintain_record.count, mould_id: @mould_maintain_record.mould_id, plan_date: @mould_maintain_record.plan_date, real_date: @mould_maintain_record.real_date }
    assert_redirected_to mould_maintain_record_path(assigns(:mould_maintain_record))
  end

  test "should destroy mould_maintain_record" do
    assert_difference('MouldMaintainRecord.count', -1) do
      delete :destroy, id: @mould_maintain_record
    end

    assert_redirected_to mould_maintain_records_path
  end
end
