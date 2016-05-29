require_relative 'observer_result'
require_relative 'observer_adapters/ping_adapter'
require_relative 'observer_adapters/http_adapter'

module Observee
  class Observer
    include Celluloid

    attr_accessor :name, :adapter_name, :adapter_data

    def initialize(params = {})
      self.name         = params.delete(:name) || params[:host]
      self.adapter_name = params.delete(:adapter)
      self.adapter      = adapter_name
      self.adapter_data = params
    end

    def check_and_log
      Observee::Logger.write check.to_h.merge(name: name)
    end

    def check
      adapter.check(**adapter_data)
    end

    private

    def adapter=(name_or_adapter, opts = nil)
      @adapter =
        case name_or_adapter
        when Symbol, String
          load_adapter(name_or_adapter, opts)
        else
          name_or_adapter if name_or_adapter.respond_to?(:check)
        end
    end

    def adapter
      @adapter || ObserverAdapters::PingAdapter
    end

    private

    def load_adapter(adapter_name, opts = nil)
      Object.const_get(
        "Observee::ObserverAdapters::" \
        "#{adapter_name.to_s.split('_').map{ |w| w.capitalize }.join}Adapter"
      )
    end
  end
end
