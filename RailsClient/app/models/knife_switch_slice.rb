class KnifeSwitchSlice < ActiveRecord::Base
  validates_presence_of :mould_id, :message => "模具号不能为空!"
  validates_presence_of :project_id, :message => "项目名不能为空!"
  validates_presence_of :terminal_leoni_id, :message => "端子莱尼号不能为空!"
  validates_presence_of :knife_type1, :message => "刀片类型不能为空!"
  validates_presence_of :knife_type1, :message => "刀片类型不能为空!"

  HEADERS=[
      '日期','端子莱尼号','模具号','项目','刀片型号1','刀片型号2','电线型号','电线截面','剖面后','验收确认','剖面前'
  ]

  # HEADERS=[
  #     'switch_date','terminal_leoni_id','mould_id','project_id','knife_type1','knife_type2','wire_type','wire_cross','image_after','is_ok','image_before'
  # ]

  def self.to_xlsx knife_switch_slices
    p = Axlsx::Package.new
    wb = p.workbook
    wb.add_worksheet(:name => "sheet1") do |sheet|
      sheet.add_row HEADERS
      knife_switch_slices.each_with_index { |slice, index|
        sheet.add_row [
                          slice.switch_date,
                          slice.terminal_leoni_id,
                          slice.mould_id,
                          slice.project_id,
                          slice.knife_type1,
                          slice.knife_type2,

                          slice.wire_type,
                          slice.wire_cross,
                          slice.image_after,
                          slice.is_ok,
                          slice.image_before
                      ]

      }
    end
    p.to_stream.read
  end
end
