module ClearInsight
  class KpiProperty<Base
    attr_accessor :name, :value

    def to_params_json
      {
          name: self.name,
          value: self.value
      }
    end
  end
end