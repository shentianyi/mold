class KnifeSwitchRecord < ActiveRecord::Base
  validates_presence_of :mould_id, :message => "模具号不能为空!"
  validates_presence_of :project_id, :message => "项目名不能为空!"
  validates_presence_of :knife_kind, :message => "刀片分类不能为空!"
  validates_presence_of :terminal_leoni_id, :message => "端子莱尼号不能为空!"
  validates_presence_of :knife_type, :message => "刀片类型不能为空!"

  before_validation :create_knife_type
  before_create :create_knife_life
  before_update :reset_knife_life

  include TimeStrf

  HEADERS=[
      '日期', '模具号', '项目', '端子莱尼号', '刀片型号', '刀片分类', '供应商', '损坏状态', '问题描述', '损坏定义', '维护人员', '数量', '维护次数',
      '机器号', '压接次数', '磨损寿命', '断裂寿命', '操作员', '验收确认', '分类', '出库单号'
  ]

  # HEADERS=[
  #     'switch_date','mould_id','project_id', terminal_leoni_id 'knife_type','knife_kind','knife_supplier', 'state', 'problem', 'damage_define', 'maintainman', 'qty', 'm_qty',
  #     'machine_id', 'press_num', 'operater', 'is_ok', 'sort', 'outbound_id'
  # ]

  def reset_knife_life
    # GM25T-027sdfs sdf 410000201-2 CW
    puts "-------------reset_knife_life----------------"
    records = KnifeSwitchRecord.where(mould_id: self[:mould_id], project_id: self[:project_id], knife_type: self[:knife_type], knife_kind: self[:knife_kind]).where("m_qty >= #{self[:m_qty]}").order(m_qty: :asc)

    press_num_before = 0
    total_life = 0
    damage_life = 0
    broken_life = 0
    records.each do |record|
      puts "press=#{record.press_num}----before= #{press_num_before} --------m_qty=#{record.m_qty}"
      if record.m_qty == 1
        press_num_before = self[:press_num]
        self[:damage_life] = 0
        self[:broken_life] = 0
        self[:total_life] = self[:damage_life] | self[:broken_life]
      else

        if record.m_qty.to_i == self[:m_qty]
          pre_record = KnifeSwitchRecord.where(mould_id: self[:mould_id], project_id: self[:project_id], knife_type: self[:knife_type], knife_kind: self[:knife_kind], m_qty: (self[:m_qty] -1)).first
          if pre_record.nil?
            self[:damage_life] = 0
            self[:broken_life] = 0
          else
            if self[:state].include? "磨损"
              self[:damage_life] = self[:press_num].to_i - pre_record.press_num
              self[:broken_life] = 0
            elsif self[:state].include? "断裂"
              self[:damage_life] = 0
              self[:broken_life] = self[:press_num].to_i - pre_record.press_num
            end
          end
          self[:total_life] = self[:damage_life] | self[:broken_life]
          press_num_before = self[:press_num]
        elsif record.m_qty.to_i == (self[:m_qty] + 1)
       puts "################press_num_before=#{press_num_before}##############record.press_num=#{record.press_num}########################################"
          if record.state.include? "磨损"
            damage_life = record.press_num - press_num_before
            broken_life = 0
          elsif record.state.include? "断裂"
            damage_life = 0
            broken_life = record.press_num - press_num_before
          end
       puts "======================#{damage_life}"
          total_life = damage_life | broken_life
          record.update(damage_life: damage_life, broken_life: broken_life, total_life: total_life)
          press_num_before = record.press_num
        end

      end
    end

  end

  def create_knife_life
    puts "-------------create_knife_life----------------"
    record = KnifeSwitchRecord.where(mould_id: self[:mould_id], project_id: self[:project_id], knife_type: self[:knife_type], knife_kind: self[:knife_kind]).order(m_qty: :desc).first
    self[:m_qty] = record.nil? ? 1 : (record.m_qty.to_i + 1)

    if self[:state].include? "磨损"
      self[:damage_life] = record.nil? ? (self[:press_num].to_i) : (self[:press_num].to_i - record.press_num)
      self[:broken_life] = 0
    elsif self[:state].include? "断裂"
      self[:damage_life] = 0
      self[:broken_life] = record.nil? ? (self[:press_num].to_i) : (self[:press_num].to_i - record.press_num)
    else
      self[:damage_life] = 0
      self[:broken_life] = 0
    end
    self[:total_life] = self[:damage_life] | self[:broken_life]
    puts "-----#{self[:total_life]}--------#{self[:damage_life]}------#{self[:broken_life]}"
  end

  def create_knife_type
    mould_detail = MouldDetail.where(mould_id: self['mould_id'], terminal_leoni_no: self['terminal_leoni_id']).first
    mould_detail.blank? ? self.errors.add(:knife_type, '未查找到对应刀片型号,请检查!') : (self['knife_type'] = MouldDetail.new().get_knife(mould_detail, self['knife_kind']))
  end

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
                          record.terminal_leoni_id,
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
