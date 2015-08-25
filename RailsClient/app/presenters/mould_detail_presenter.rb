class MouldDetailPresenter #<Presenter

  def initialize(mould_detail)
    @mould_detail = mould_detail
  end

  def parse_state
    if @mould_detail.next_time.nil?
      @mould_detail.mould_state
    else
      days = (DateTime.parse(@mould_detail.next_time.to_s) - DateTime.parse(Date.today.to_s)).to_s.sub(/\/1/, '').to_i
      if days >= 30
        '未过期'
      elsif (0..30).include? days
        '即将过期'
      else
        '过期'
      end
    end
  end

end