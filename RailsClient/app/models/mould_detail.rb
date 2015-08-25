class MouldDetail < ActiveRecord::Base
 # validates :position, uniqueness: {message: '该模具明细信息已录入,请检查!'}

  validates_presence_of :mould_id, :message => "模具号不能为空!"
  validates_presence_of :mould_type, :message => "模具型号不能为空!"
  validates_presence_of :mould_supplier, :message => "模具供应商不能为空!"
  validates_presence_of :wire_type, :message => "电线型号不能为空!"
  validates_presence_of :wire_cross, :message => "电线截面不能为空!"
  validates_presence_of :terminal_leoni_no, :message => "端子莱尼号不能为空!"

  before_validation :create_uuid
  #before_save :create_uuid
 # before_update :create_uuid

  include TimeStrf

  HEADERS=[
      '模具号', '端子莱尼号', '端子供应商', '防水塞', '使用范围', '电线型号', '电线截面', '原始参数CH',
      '原始参数CW', '实测参数CH', '实测参数CW', '实测参数ICH', '实测参数ICW', '步骤DCH', '步骤ICH', '下次批准日期',
      '状态', '模具型号', '模具供应商', '芯线上刀', '绝缘上刀', '芯线下刀', '绝缘下刀', '上冲头', '切断刀', '切断刀座',
      '送料爪', '后凹槽', '前凹槽', '备注', '油杯', '模具买到日期', '放行报告', '固定资产号', '是否闲置', '闲置日期'
  ]

  # HEADERS=[
  #     'mould_id', 'terminal_leoni_no', 'terminal_supplier', 'stopwater', 'use_range', 'wire_type', 'wire_cross', 'original_param_ch',
  #     'original_param_cw', 'actual_param_ch', 'actual_param_cw', 'actual_param_ich', 'actual_param_icw', 'step_dch_id', 'step_ich_id', 'next_time',
  #     'mould_state', 'mould_type', 'mould_supplier', 'c_up_knife', 'i_up_knife', 'c_down_knife', 'i_down_knife', 'upper_punch', 'coc', 'coh',
  #     'feeding_claw', 'after_groove', 'before_groove', 'note', 'oil_cup', 'buy_time', 'release_report', 'fixed_asset_id', 'is_idle', 'idle_time'
  # ]

  def create_uuid
    position = self['mould_id'] + self['terminal_leoni_no'] + self['wire_type'] + self['wire_cross']
    self['position'] = position.sub(/\.0/, '')
    self.errors.add(:position,'该模具明细信息已录入,请检查!') if (self.new_record? ? MouldDetail.where('position=?',position).first : MouldDetail.where('position=? and id <>?',position, id).first)
  end

  def self.to_xlsx mould_details
    p = Axlsx::Package.new
    wb = p.workbook
    wb.add_worksheet(:name => "sheet1") do |sheet|
      sheet.add_row HEADERS
      mould_details.each_with_index { |mould, index|
        sheet.add_row [
                          #index+1,
                          mould.mould_id,
                          mould.terminal_leoni_no,
                          mould.terminal_supplier,
                          mould.stopwater,
                          mould.use_range,
                          mould.wire_type,
                          mould.wire_cross,

                          mould.original_param_ch,
                          mould.original_param_cw,
                          mould.actual_param_ch,
                          mould.actual_param_cw,
                          mould.actual_param_ich,
                          mould.actual_param_icw,
                          mould.step_dch_id,

                          mould.step_ich_id,
                          mould.next_time,
                          mould.mould_state,
                          mould.mould_type,
                          mould.mould_supplier,
                          mould.c_up_knife,
                          mould.i_up_knife,

                          mould.c_down_knife,
                          mould.i_down_knife,
                          mould.upper_punch,
                          mould.coc,
                          mould.coh,
                          mould.feeding_claw,
                          mould.after_groove,

                          mould.before_groove,
                          mould.note,
                          mould.oil_cup,
                          mould.buy_time,
                          mould.release_report,
                          mould.fixed_asset_id,
                          mould.is_idle ? '是' : '否',
                          mould.idle_time
                      ]

      }
    end
    p.to_stream.read
  end
end
