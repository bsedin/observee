module Observee
  module LoggerAdapters
    class InfluxdbAdapter
      def initialize(opts = {})
        @influxdb = InfluxDB::Client.new opts[:database],
          username: opts[:username],
          password: opts[:password]
      end

      def write(payload = {})
        payload[:duration] ||= 0
        name = payload.delete(:name)
        time = payload.delete(:time).to_i
        tags = { state: payload.delete(:state).to_s }
        data = {
          values: payload,
          timestamp: time,
          tags: tags
        }

        @influxdb.write_point(name, data)
      end
    end
  end
end
