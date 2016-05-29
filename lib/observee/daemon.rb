require 'yaml'


module Observee
  class Daemon
    class << self
      def run
        observers_config = YAML.load_file(config_file)
        observers_config.each do |observer_data|
          observer_data = observer_data.map{ |k, v| [k.to_sym, v] }.to_h
          @supervisor = Observer.supervise(args: [observer_data])
        end

        timers = Timers::Group.new
        timers.now_and_every(5) do
          observers.each do |observer|
            observer.async.check_and_log
          end
        end

        begin
          loop do
            timers.wait
          end
        rescue Exception => e
          supervisor.terminate
          raise e
        end
      end

      def stop
        if supervisor
          supervisor.terminate
        end
      end

      def restart
        stop
        run
      end

      def config_file=(path)
        @config_file = File.expand_path(path)
      end

      def config_file
        @config_file || File.expand_path('~/.config/observee.yml')
      end

      private

      def supervisor
        @supervisor
      end

      def observers
        supervisor.actors
      end
    end
  end
end
