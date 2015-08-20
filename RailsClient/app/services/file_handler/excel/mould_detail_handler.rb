module FileHandler
  module Excel
    class MouldDetailHandler<Base
      HEADERS=[
          'mould_id', 'position', 'terminal_leoni_no', 'terminal_supplier', 'stopwater', 'use_range', 'wire_type', 'wire_cross', 'original_param_ch',
          'original_param_cw', 'actual_param_ch', 'actual_param_cw', 'actual_param_ich', 'actual_param_icw', 'step_dch_id', 'step_ich_id', 'next_time',
          'mould_state', 'mould_type', 'mould_supplier', 'c_up_knife', 'i_up_knife', 'c_down_knife', 'i_down_knife', 'upper_punch', 'coc', 'coh',
          'feeding_claw', 'after_groove', 'before_groove', 'note', 'oil_cup', 'buy_time', 'release_report', 'fixed_asset_id', 'is_idle', 'idle_time'
      ]

      def self.import(file)
        msg = Message.new
        book = Roo::Excelx.new file.full_path
        book.default_sheet = book.sheets.first

        validate_msg = validate_import(file)
        if validate_msg.result
          #validate file
          begin
            MouldDetail.transaction do
              2.upto(book.last_row) do |line|
                row = {}
                HEADERS.each_with_index do |k, i|
                  row[k] = book.cell(line, i+1).to_s.strip
                end

                s = MouldDetail.new(row)
                unless s.save
                  puts s.errors.to_json
                  raise s.errors.to_json
                end
              end
            end
            msg.result = true
            msg.content = "导入模具维护记录成功！"
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

        if MouldDetail.find_by_mould_id(row['mould_id'].to_i)
          msg.contents<<"该模具已存在！"
        end

        unless msg.result=(msg.contents.size==0)
          msg.content=msg.contents.join('/')
        end
        msg
      end
    end
  end
end