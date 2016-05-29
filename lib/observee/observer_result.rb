module Observee
  class ObserverResult
    attr_accessor :adapter, :alive, :duration, :adapter_data, :exception

    def initialize(params = {})
      params.each do |attr, value|
        public_send("#{attr}=", value)
      end if params
    end

    def dead?
      !alive
    end

    def to_h
      { alive: alive,
        duration: duration
      }
    end
  end
end
