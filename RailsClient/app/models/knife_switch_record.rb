class KnifeSwitchRecord < ActiveRecord::Base
  validates_presence_of :mould_id, :message => "模具号不能为空!"
  validates_presence_of :project_id, :message => "项目名不能为空!"
  validates_presence_of :knife_kind, :message => "刀片分类不能为空!"
  validates_presence_of :knife_type, :message => "刀片类型不能为空!"


  include TimeStrf

  HEADERS=[
      '日期','模具号','项目','刀片型号','刀片分类','供应商', '损坏状态', '问题描述', '损坏定义', '维护人员', '数量', '维护次数',
      '机器号', '压接次数', '磨损寿命', '断裂寿命', '操作员', '验收确认', '分类', '出库单号'
  ]

  # HEADERS=[
  #     'switch_date','mould_id','project_id','knife_type','knife_kind','knife_supplier', 'state', 'problem', 'damage_define', 'maintainman', 'qty', 'm_qty',
  #     'machine_id', 'press_num', 'operater', 'is_ok', 'sort', 'outbound_id'
  # ]

  def self.to_xlsx knife_switch_records
    p = Axlsx::Package.new
    wb = p.workbook
    wb.add_worksheet(:name => "sheet1") do |sheet|
      sheet.add_row HEADERS
      knife_switch_records.each_with_index { |record, index|
        sheet.add_row [
                          record.switch_date,
                          record.mould_id,
                          record.project_id,
                          record.knife_type,
                          record.knife_kind,
                          record.knife_supplier,
                          record.state,

                          record.problem,
                          record.damage_define,
                          record.maintainman,
                          record.qty,
                          record.m_qty,
                          record.machine_id,
                          record.press_num,
                          record.damage_life,
                          record.broken_life,

                          record.operater,
                          record.is_ok,
                          record.sort,
                          record.outbound_id
                      ]

      }
    end
    p.to_stream.read
  end

end
