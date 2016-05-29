require 'net/ping'

module Observee
  module ObserverAdapters
    class PingAdapter
      class << self
        def check(proto: :tcp, host:, port: 80, timeout: 5)
          ping =
            case proto
            when :tcp
              Net::Ping::TCP.new(host, port, timeout)
            when :icmp
              Net::Ping::ICMP.new(host, port, timeout)
            else
              raise RuntimeError, "Unknown protocol #{proto}"
            end

          output = {
            adapter: :ping,
            alive: false,
            adapter_data: {
              host: host,
              port: port,
              proto: proto
            }
          }

          if ping.ping
            output[:alive] = true
            output[:duration] = ping.duration
          end

          ObserverResult.new(**output)
        end
      end
    end
  end
end
