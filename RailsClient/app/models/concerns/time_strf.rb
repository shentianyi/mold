module TimeStrf
  extend ActiveSupport::Concern

  included do
    def method_missing(method,*args,&block)
      if method.match(/\w+_day_str/)
        date=self.send(method.to_s.sub(/_day_str/,''))
        date.blank? ? '' : date.localtime.strftime('%Y-%m-%d')
      else
        super
      end
    end
  end
end