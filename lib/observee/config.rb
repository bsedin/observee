module Observee
  class Config
    class << self
      def reload!
        @config = nil
      end

      def config
        @config ||= ::Hashie::Mash.load(config_file)
      end

      def config_file=(path)
        @config_file = File.expand_path(path)
        @config = nil
      end

      def config_file
        @config_file || File.expand_path('~/.config/observee.yml')
      end

      def method_missing(*args)
        config.send(*args)
      end
    end
  end
end
