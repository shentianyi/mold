class MouldDetail < ActiveRecord::Base
  validates :mould_id, presence: true, uniqueness: {message: '模具号不能重复!'}

  validates_presence_of :mould_type, :message => "模具型号不能为空!"
  validates_presence_of :mould_supplier, :message => "模具供应商不能为空!"
  validates_presence_of :position, :message => "库位不能为空!"
  validates_presence_of :terminal_leoni_no, :message => "端子莱尼号不能为空!"
end
