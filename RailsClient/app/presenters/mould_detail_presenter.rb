class MouldDetailPresenter #<Presenter
  NODATE = ''
  INDATE = '未过期'
  OUTDATE = '过期'
  WILLOUTDATE = '即将过期'

  def initialize(mould_detail)
    @mould_detail = mould_detail
  end

  def parse_state_color
    if @mould_detail.next_time.nil?
      'NOMAL'
    else
      days = (DateTime.parse(@mould_detail.next_time.to_s) - DateTime.parse(Date.today.to_s)).to_s.sub(/\/1/, '').to_i
      if days >= 30
        'GREEN'
      elsif (0..30).include? days
        'RED'
      else
        'YELLOW'
      end
    end
  end

  def self.display state
    case state
      when 'NOMAL'
        NODATE
      when 'GREEN'
        INDATE
      when 'RED'
        OUTDATE
      when 'YELLOW'
        WILLOUTDATE
    end
  end

end