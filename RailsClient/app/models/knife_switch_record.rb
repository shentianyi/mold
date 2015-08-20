class KnifeSwitchRecord < ActiveRecord::Base
  validates_presence_of :mould_id, :message => "模具号不能为空!"
  validates_presence_of :project_id, :message => "项目名不能为空!"
  validates_presence_of :knife_kind, :message => "刀片分类不能为空!"
  validates_presence_of :knife_type, :message => "刀片类型不能为空!"
end
