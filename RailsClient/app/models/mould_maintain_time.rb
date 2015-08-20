class MouldMaintainTime < ActiveRecord::Base
  validates_presence_of :mould_id, :message => "模具号不能为空!"
  validates_presence_of :project_id, :message => "项目名不能为空!"
  validates_presence_of :device_id, :message => "设备号不能为空!"
  validates_presence_of :serviceman, :message => "维修人员不能为空!"
  validates_presence_of :start_time, :message => "开始时间不能为空!"
  validates_presence_of :end_time, :message => "结束时间不能为空!"
end
