require 'logger'
require 'json'

module Observee
  module LoggerAdapters
    class LoggerAdapter
      def initialize(output = STDOUT)
        @logger = ::Logger.new(output)
      end

      def write(payload = {})
        @logger.info payload.to_json
      end
    end
  end
end
