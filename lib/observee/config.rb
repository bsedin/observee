module Observee
  class Config
    def initialize
    end

    def method_missing(*args)
    end

    private

    def adapter=(name_or_adapter, opts = nil)
      @adapter =
        case name_or_adapter
        when Symbol, String
          load_adapter(name_or_adapter, opts)
        else
          name_or_adapter if name_or_adapter.respond_to?(:fetch)
        end
    end

    def adapter
      @adapter || ConfigAdapters::FileAdapter
    end

    private

    def load_adapter(adapter_name, opts = nil)
      Object.const_get(
        "Observee::ConfigAdapters::" \
        "#{adapter_name.to_s.split('_').map{ |w| w.capitalize }.join}Adapter"
      )
    end
  end
end
