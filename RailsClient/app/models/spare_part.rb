class SparePart < ActiveRecord::Base
  validates_presence_of :mould_id, :message => "模具号不能为空!"
  validates_presence_of :project_id, :message => "项目名不能为空!"
end
