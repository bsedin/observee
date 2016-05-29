require 'net/http'

module Observee
  module ObserverAdapters
    class HttpAdapter
      class << self
        attr_accessor :success_codes

        def success_codes
          @success_codes || [200]
        end

        def check(proto: :http, host:, port: 80, path: '/', timeout: 5, method: :get)

          output = {
            adapter: :http,
            alive: false,
            adapter_data: {
              proto: proto,
              host: host,
              port: port,
              path: path,
              method: method
            }
          }

          begin
            Net::HTTP.start(host, port, use_ssl: proto == :https) do |http|
              response = nil

              duration = Hitimes::Interval.measure do
                response = http.request(Net::HTTP::Get.new(path))
              end

              if response
                output[:adapter_data][:code] = code = response.code.to_i

                if success_codes.include?(code)
                  output[:alive] = true
                  output[:duration] = duration
                end
              end
            end
          rescue => e
            output[:exception] = e
          end

          ObserverResult.new(**output)
        end
      end
    end
  end
end
