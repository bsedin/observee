require 'yaml'


module Observee
  class Daemon
    class << self
      def run
        Observee.config.observers.each do |observer_data|
          observer_data = observer_data.map{ |k, v| [k.to_sym, v] }.to_h
          @supervisor = Observer.supervise(args: [observer_data])
        end

        timers = Timers::Group.new
        timers.now_and_every(Observee.config.interval || 5) do
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
