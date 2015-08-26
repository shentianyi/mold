module FileHandler
  module Excel
    class KnifeSwitchRecordHandler<Base
      HEADERS=[
          'switch_date', 'mould_id', 'project_id', 'terminal_leoni_id', 'knife_kind', 'knife_supplier', 'state', 'problem', 'damage_define', 'maintainman', 'qty',
          'machine_id', 'press_num', 'operater', 'is_ok', 'sort', 'outbound_id'
      ]

      def self.import(file)
        msg = Message.new
        book = Roo::Excelx.new file.full_path
        book.default_sheet = book.sheets.first

        validate_msg = validate_import(file)
        if validate_msg.result
          #validate file
          begin
            KnifeSwitchRecord.transaction do
              2.upto(book.last_row) do |line|
                row = {}
                HEADERS.each_with_index do |k, i|
                  row[k] = book.cell(line, i+1).to_s.strip
                  row[k] = row[k].sub(/\.0/, '') if k=='mould_id'
                  row[k] = row[k].sub(/\.0/, '') if k=='terminal_leoni_id'
                end

                # record = KnifeSwitchRecord.where(mould_id: mould_id, project_id: row['project_id'], knife_type: row['knife_type'], knife_kind: row['knife_kind']).order(m_qty: :desc).first
                # total_count = record.nil? ? 1 : (record.m_qty.to_i + 1)
                #
                # if row['state'].to_s.include?("磨损")
                #   damage_life = record.nil? ? (row['press_num'].to_i) : (row['press_num'].to_i - record.press_num)
                #   broken_life = 0
                # elsif row['state'].to_s.include?("断裂")
                #   damage_life = 0
                #   broken_life = record.nil? ? (row['press_num'].to_i) : (row['press_num'].to_i - record.press_num)
                # else
                #   damage_life = 0
                #   broken_life = 0
                # end
                # total_life = broken_life | damage_life
                #
                # puts "-----#{broken_life}--------#{damage_life}------#{total_life}"
                # k = KnifeSwitchRecord.new({mould_id: mould_id, project_id: row['project_id'], terminal_leoni_id: row['terminal_leoni_id'], switch_date: row['switch_date'], knife_kind: row['knife_kind'],
                #                          knife_supplier: row['knife_supplier'], state: row['state'], problem: row['problem'], damage_define: row['damage_define'], maintainman: row['maintainman'],
                #                          qty: row['qty'], m_qty: total_count, machine_id: row['machine_id'], press_num: row['press_num'], damage_life: damage_life,
                #                          broken_life: broken_life, total_life: total_life, operater: row['operater'], is_ok: row['is_ok'], sort: row['sort'], outbound_id: row['outbound_id'].sub(/\.0/, '')})
                #
                k = KnifeSwitchRecord.new(row)
                if k.save

                else
                  raise k.errors.to_json
                end
              end
            end
            msg.result = true
            msg.content = "导入模具换刀记录成功"
          rescue => e
            puts e.backtrace
            msg.result = false
            msg.content = e.message
          end
        else
          msg.result = false
          msg.content = validate_msg.content
        end
        msg
      end

      def self.validate_import file
        tmp_file=full_tmp_path(file.original_name)
        msg = Message.new(result: true)
        book = Roo::Excelx.new file.full_path
        book.default_sheet = book.sheets.first

        p = Axlsx::Package.new
        p.workbook.add_worksheet(:name => "Basic Worksheet") do |sheet|
          sheet.add_row HEADERS+['Error Msg']
          #validate file
          2.upto(book.last_row) do |line|
            row = {}
            HEADERS.each_with_index do |k, i|
              row[k] = book.cell(line, i+1).to_s.strip
            end

            mssg = validate_row(row, line)
            if mssg.result
              sheet.add_row row.values
            else
              if msg.result
                msg.result = false
                msg.content = "下载错误文件<a href='/files/#{Base64.urlsafe_encode64(tmp_file)}'>#{::File.basename(tmp_file)}</a>"
              end
              sheet.add_row row.values<<mssg.content
            end
          end
        end
        p.use_shared_strings = true
        p.serialize(tmp_file)
        msg
      end

      def self.validate_row(row, line)
        msg = Message.new(contents: [])

        # if (row['end_time'].to_s.to_time - row['start_time'].to_s.to_time) <= 0
        #   msg.contents << "维修时间不正确!"
        # end

        unless msg.result=(msg.contents.size==0)
          msg.content=msg.contents.join('/')
        end
        msg
      end
    end
  end
end