class CSV
  class Row
    def strip
      puts "1231111111111111111111111111111111"
      self.each do |value|
        value[1].strip! if value[1]
      end
    end
  end
end
