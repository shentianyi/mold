class SparePart < ActiveRecord::Base
  validates_presence_of :mould_id, :message => "模具号不能为空!"
  validates_presence_of :project_id, :message => "项目名不能为空!"

  HEADERS=[
      '日期', '模具号', '项目', '备件型号', '型号分类', '损坏状态', '维护人员', '数量', '机器号', '出库单号'
  ]
  # HEADERS=[
  #     'record_date', 'mould_id', 'project_id', 'spare_type', 'spare_kind', 'broken_state', 'maintainman', 'qty', 'machine_id', 'outbound_id'
  # ]


  def self.to_xlsx spare_parts
    p = Axlsx::Package.new
    wb = p.workbook
    wb.add_worksheet(:name => "sheet1") do |sheet|
      sheet.add_row HEADERS
      spare_parts.each_with_index { |part, index|
        sheet.add_row [
                          part.record_date,
                          part.mould_id,
                          part.project_id,
                          part.spare_type,
                          part.spare_kind,
                          part.broken_state,
                          part.maintainman,

                          part.qty,
                          part.machine_id,
                          part.outbound_id
                      ]

      }
    end
    p.to_stream.read
  end
end
