module Observee
  class ObserverResult
    attr_accessor :adapter, :state, :duration, :time, :adapter_data, :exception

    def initialize(params = {})
      params.each do |attr, value|
        public_send("#{attr}=", value)
      end if params
    end

    def dead?
      state != 'ok'
    end

    def to_h
      { state: state,
        duration: duration,
        time: time
      }
    end
  end
end
