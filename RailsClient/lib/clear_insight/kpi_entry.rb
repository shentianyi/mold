module ClearInsight
  class KpiEntry<Base

    # kpi_property can be a array
    attr_accessor :entry_id, :email, :kpi_id, :date, :value, :kpi_properties


    def to_params_json
      json={
          entry_id: self.entry_id,
          email: self.email,
          kpi_id: self.kpi_id,
          date: self.date,
          value: self.value
      }

      if self.kpi_properties
        json[:kpi_properties]=kpi_properties.is_a?(Array) ? kpi_properties.collect { |kp| kp.to_params_json } : kpi_properties.to_params_json
      end

      json
    end
  end
end