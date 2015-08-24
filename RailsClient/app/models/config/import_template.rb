class ImportTemplate
  MOULD_DETAIL_EXCEL_TEMPLATE='mould_detail.xlsx'
  MOULD_MAINTAIN_RECORD_EXCEL_TEMPLATE='mould_maintain_record.xlsx'
  MOULD_MAINTAIN_TIME_EXCEL_TEMPLATE='mould_maintain_time.xlsx'
  KNIFE_SWITCH_SLICE_EXCEL_TEMPLATE='knife_switch_slice.xlsx'
  KNIFE_SWITCH_RECORD_EXCEL_TEMPLATE='knife_switch_record.xlsx'
  SPARE_PART_EXCEL_TEMPLATE='spare_part.xlsx'


  def self.method_missing(method_name, *args, &block)
    if method_name.to_s.include?('_template')
      return Base64.urlsafe_encode64(File.join($template_file_path, self.const_get(method_name.upcase)))
    else
      super
    end
  end
end