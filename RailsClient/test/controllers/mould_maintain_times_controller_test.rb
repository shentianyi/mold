require 'test_helper'

class MouldMaintainTimesControllerTest < ActionController::TestCase
  setup do
    @mould_maintain_time = mould_maintain_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mould_maintain_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mould_maintain_time" do
    assert_difference('MouldMaintainTime.count') do
      post :create, mould_maintain_time: { code: @mould_maintain_time.code, device_id: @mould_maintain_time.device_id, err_note: @mould_maintain_time.err_note, feed_code: @mould_maintain_time.feed_code, mould_id: @mould_maintain_time.mould_id, project_id: @mould_maintain_time.project_id, serviceman: @mould_maintain_time.serviceman, solution_method: @mould_maintain_time.solution_method }
    end

    assert_redirected_to mould_maintain_time_path(assigns(:mould_maintain_time))
  end

  test "should show mould_maintain_time" do
    get :show, id: @mould_maintain_time
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mould_maintain_time
    assert_response :success
  end

  test "should update mould_maintain_time" do
    patch :update, id: @mould_maintain_time, mould_maintain_time: { code: @mould_maintain_time.code, device_id: @mould_maintain_time.device_id, err_note: @mould_maintain_time.err_note, feed_code: @mould_maintain_time.feed_code, mould_id: @mould_maintain_time.mould_id, project_id: @mould_maintain_time.project_id, serviceman: @mould_maintain_time.serviceman, solution_method: @mould_maintain_time.solution_method }
    assert_redirected_to mould_maintain_time_path(assigns(:mould_maintain_time))
  end

  test "should destroy mould_maintain_time" do
    assert_difference('MouldMaintainTime.count', -1) do
      delete :destroy, id: @mould_maintain_time
    end

    assert_redirected_to mould_maintain_times_path
  end
end
