class MouldMaintainRecord < ActiveRecord::Base
  validates_presence_of :mould_id, :message => "模具号不能为空!"
  validates_presence_of :plan_date, :message => "计划日期不能为空!"

  include TimeStrf

  # HEADERS=[
  #     '模具号', '计划日期', '实际日期', '备注'
  # ]

  # def self.to_xlsx mould_maintain_records
  #   p = Axlsx::Package.new
  #   wb = p.workbook
  #   wb.add_worksheet(:name => "sheet1") do |sheet|
  #     sheet.add_row HEADERS
  #     mould_maintain_records.each_with_index { |record, index|
  #
  #
  #
  #
  #
  #       sheet.add_row [
  #                         record.switch_date,
  #                         record.mould_id,
  #                         record.project_id,
  #                         record.knife_type,
  #                         record.knife_kind,
  #                         record.knife_supplier,
  #                         record.state
  #                     ]
  #
  #     }
  #   end
  #   p.to_stream.read
  # end
end
