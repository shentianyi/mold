module FileHandler
  module Excel
    class SparePartHandler<Base
      HEADERS=[
          'record_date', 'mould_id', 'project_id', 'spare_type', 'spare_kind', 'broken_state', 'maintainman', 'qty', 'machine_id', 'outbound_id'
      ]

      def self.import(file)
        msg = Message.new
        book = Roo::Excelx.new file.full_path
        book.default_sheet = book.sheets.first

        validate_msg = validate_import(file)

        if validate_msg.result
          #validate file
          begin
            SparePart.transaction do
              2.upto(book.last_row) do |line|
                row = {}

                HEADERS.each_with_index do |k, i|
                  row[k] = book.cell(line, i+1).to_s.strip
                  row[k] = row[k].sub(/\.0/, '') if k=='mould_id'
                  row[k] = row[k].sub(/\.0/, '') if k=='outbound_id'
                end

                SparePart.create(row)
              end
            end
            msg.result = true
            msg.content = "导入备件信息成功"
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

      def self.validate_row(row,line)
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