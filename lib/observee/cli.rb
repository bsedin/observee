require 'thor'

module Observee
  module Cli
    def self.start(opts = nil)
      Base.start(opts)
    end

    class Daemon < ::Thor
      desc "status", "show daemon status"
      def status
        raise RuntimeError, 'Not implemented yet'
      end

      desc "start", "start daemon"
      option :c, banner: "<config_file>"
      def start
        if options[:c]
          ::Observee::Config.config_file = options[:c]
        end
        ::Observee::Daemon.run
      end

      desc "stop", "stop daemon"
      def stop
        ::Observee::Daemon.stop
      end

      desc "restart", "restart daemon"
      option :c, banner: "<config_file>"
      def restart
        if options[:c]
          ::Observee::Config.config_file = options[:c]
        end
        ::Observee::Daemon.restart
      end
    end

    class Base < ::Thor
      desc "daemon SUBCOMMAND ...ARGS", "manage observee daemon"
      subcommand "daemon", Daemon
    end
  end
end
