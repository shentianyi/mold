require 'clear_insight'

class ClearInsightService

  DEFAULT_EMAIL='mj@leoni.com'

  KPI_DEFINE=[
      {
          kpi_id: 39,
          model: 'KnifeSwitchRecord',
          email: DEFAULT_EMAIL,
          date_field: 'switch_date',
          value_field: 'total_life',
          property_map: {mould_id: '模具号', knife_type: '刀片类型', knife_kind: '刀片分类', m_qty: '数量', knife_supplier: '供应商', state: '损坏状态'}
      },
      {
          kpi_id: 40,
          model: 'KnifeSwitchRecord',
          email: DEFAULT_EMAIL,
          date_field: 'switch_date',
          value_field: 1,
          property_map: {mould_id: '模具号', project_id: '项目', knife_type: '刀片类型', knife_kind: '刀片分类', knife_supplier: '供应商', state: '损坏状态',
                         problem: '问题描述', damage_define: '损坏定义', machine_id: '机器号', operater: '操作员', sort: '分类', outbound_id: '出库单号'
          }
      },
      {
          kpi_id: 41,
          model: 'MouldMaintainTime',
          email: DEFAULT_EMAIL,
          date_field: 'maintain_date',
          value_field: 'downtime',
          property_map: {project_id: '项目', device_id: '设备编号', mould_id: '模具号', serviceman: '抢修人员', err_note: '问题描述',
                         solution_method: '解决措施', code: '代码', feed_code: '送料方式'}
      }
  ]

  # entry data to clear insight
  def entry(within_time=true, minutes=120)
    time=(Time.now-minutes.minutes).utc
    puts time
    puts minutes
    puts within_time
    # raise
    KPI_DEFINE.each do |kpi_define|
      model=kpi_define[:model].classify.constantize
      (within_time ?  model.where('updated_at >= ?', time) : model.all).each do |item|
        properties={}
        puts "new post: #{Time.now}----#{item.to_json}"
        kpi_define[:property_map].each do |k, v|
          if (vv=item.send(k)).present?
            properties[v]=vv
          end
        end
        kpi_entry=ClearInsight::KpiEntry.new(
            entry_id: generate_entry_id(item, kpi_define[:kpi_id]),
            email: kpi_define[:email],
            kpi_id: kpi_define[:kpi_id],
            date: item.send(kpi_define[:date_field]).utc,
            value: kpi_define[:value_field].is_a?(String) ? item.send(kpi_define[:value_field]) : kpi_define[:value_field],
            validate: false,
            kpi_properties: properties
        )

        ClearInsight::Client.new.entry(kpi_entry)
      end
    end
  end

  def generate_entry_id(item, kpi_id)
    "mold-#{kpi_id}-#{item.class}-#{item.id}"
  end
end