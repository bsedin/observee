require 'yaml'

module Observee
  module ConfigAdapters
    class FileAdapter
      def initialize(filename)
        @config = ::Config.new(output)
      end

      def write(payload = {})
        @logger.info payload.to_json
      end
    end
  end
end
