class MouldDetail < ActiveRecord::Base
  validates :mould_id, presence: true, uniqueness: {message: '模具号不能重复!'}

  validates_presence_of :mould_type, :message => "模具型号不能为空!"
  validates_presence_of :mould_supplier, :message => "模具供应商不能为空!"
  validates_presence_of :position, :message => "库位不能为空!"
  validates_presence_of :terminal_leoni_no, :message => "端子莱尼号不能为空!"


  def self.to_xlsx mould_details
    # p = Axlsx::Package.new
    # wb = p.workbook
    # wb.add_worksheet(:name => "sheet1") do |sheet|
    #   #sheet.add_row ["序号", "零件号", "仓库号", "库位号", "数量", "FIFO", "创建时间", "唯一码"]
    #   mould_details.each_with_index { |mould, index|
    #     if n_storage.id && n_storage.id != ""
    #       sheet.add_row [
    #                         index+1,
    #                         # n_storage.partNr,
    #                         # n_storage.ware_house_id,
    #                         # n_storage.position,
    #                         # n_storage.total_qty,
    #                         # n_storage.fifo.present? ? n_storage.fifo.localtime.strftime("%Y-%m-%d %H:%M") : '',
    #                         # n_storage.created_at.present? ? n_storage.created_at.localtime.strftime("%Y-%m-%d %H:%M") : '',
    #                         # n_storage.packageId
    #                     ]
    #     end
    #   }
    # end
    # p.to_stream.read
  end
end
