require_relative 'logger_adapters/logger_adapter'
require_relative 'logger_adapters/influxdb_adapter'

module Observee
  class Logger
    class << self
      def write(*args)
        adapter.write(*args)
      end

      def adapter=(*args)
        args.flatten!
        name_or_adapter = args.shift
        @adapter =
          case name_or_adapter
          when Symbol, String
            load_adapter(name_or_adapter, *args)
          else
            name_or_adapter.new(*args) if name_or_adapter.respond_to?(:write)
          end
      end

      def adapter
        @adapter || LoggerAdapters::LoggerAdapter.new
      end

      private

      def load_adapter(adapter_name, *args)
        Object.const_get(
          "Observee::LoggerAdapters::" \
          "#{adapter_name.to_s.split('_').map{ |w| w.capitalize }.join}Adapter"
        ).new(*args)
      end
    end
  end
end
