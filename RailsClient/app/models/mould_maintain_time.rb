class MouldMaintainTime < ActiveRecord::Base
  validates_presence_of :mould_id, :message => "模具号不能为空!"
  validates_presence_of :project_id, :message => "项目名不能为空!"
  validates_presence_of :device_id, :message => "设备号不能为空!"
  validates_presence_of :serviceman, :message => "维修人员不能为空!"
  validates_presence_of :start_time, :message => "开始时间不能为空!"
  validates_presence_of :end_time, :message => "结束时间不能为空!"

  before_save :calc_downtime

  include TimeStrf

  HEADERS=[
      '项目','日期','设备编号','模具号','抢修人员','开始时间','结束时间', 'Downtime', '问题描述','解决措施','代码','送料方式'
  ]
  # HEADERS=[
  #     'project_id','maintain_date','device_id','mould_id','serviceman','start_time','end_time','err_note','solution_method','code','feed_code'
  # ]

  def calc_downtime
    unless self[:end_time].empty? && self[:start_time].empty?
      puts 's---------------------------------------'
      self[:downtime] = (self[:end_time].to_s.to_time - self[:start_time].to_s.to_time) / 60
    end
  end

  def self.to_xlsx mould_maintain_times
    p = Axlsx::Package.new
    wb = p.workbook
    wb.add_worksheet(:name => "sheet1") do |sheet|
      sheet.add_row HEADERS
      mould_maintain_times.each_with_index { |mould, index|
        sheet.add_row [
                          mould.project_id,
                          mould.maintain_date,
                          mould.device_id,
                          mould.mould_id,
                          mould.serviceman,
                          mould.start_time,
                          mould.end_time,

                          mould.downtime,
                          mould.err_note,
                          mould.solution_method,
                          mould.code,
                          mould.feed_code
                      ]

      }
    end
    p.to_stream.read
  end
end
