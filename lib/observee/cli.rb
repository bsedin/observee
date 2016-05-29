require 'thor'

module Observee
  module Cli
    def self.start(opts = nil)
      Base.start(opts)
    end

    class Daemon < ::Thor
      desc "status", "show daemon status"
      def status
        puts "Daemon status"
      end

      desc "start", "start daemon"
      def start
        puts "Daemon start"
      end

      desc "stop", "stop daemon"
      def stop
        puts "Daemon stop"
      end

      desc "restart", "restart daemon"
      def restart
        puts "Daemon restart"
      end

      desc "reload", "reload daemon configuration"
      def reload
        puts "Daemon reload"
      end
    end

    class Base < ::Thor
      desc "daemon SUBCOMMAND ...ARGS", "manage observee daemon"
      subcommand "daemon", Daemon
    end
  end
end
