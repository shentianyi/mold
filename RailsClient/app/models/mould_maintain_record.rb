class MouldMaintainRecord < ActiveRecord::Base
  validates_presence_of :mould_id, :message => "模具号不能为空!"
  validates_presence_of :plan_date, :message => "计划日期不能为空!"
end
