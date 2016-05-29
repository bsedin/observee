require_relative 'logger_adapters/logger_adapter'

module Observee
  class Logger
    class << self
      def write(**payload)
        adapter.write(payload)
      end

      def adapter=(name_or_adapter, opts = nil)
        @adapter =
          case name_or_adapter
          when Symbol, String
            load_adapter(name_or_adapter, opts)
          else
            name_or_adapter.new(opts) if name_or_adapter.respond_to?(:write)
          end
      end

      def adapter
        @adapter || LoggerAdapters::LoggerAdapter.new
      end

      private

      def load_adapter(adapter_name, opts = nil)
        Object.const_get(
          "Observee::LoggerAdapters::" \
          "#{adapter_name.to_s.split('_').map{ |w| w.capitalize }.join}Adapter"
        ).new(opts)
      end
    end
  end
end
