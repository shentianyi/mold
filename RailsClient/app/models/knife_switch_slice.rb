class KnifeSwitchSlice < ActiveRecord::Base
  validates_presence_of :mould_id, :message => "模具号不能为空!"
  validates_presence_of :project_id, :message => "项目名不能为空!"
  validates_presence_of :terminal_leoni_id, :message => "端子莱尼号不能为空!"
  validates_presence_of :knife_type1, :message => "刀片类型不能为空!"
  validates_presence_of :knife_type1, :message => "刀片类型不能为空!"
end
