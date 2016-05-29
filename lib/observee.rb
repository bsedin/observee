require 'celluloid/current'
require 'hitimes'
require 'timers'

require 'observee/version'
require 'observee/logger'
require 'observee/observer'
require 'observee/config'
require 'observee/daemon'

module Observee
  class << self
    def config
      Observer::Config
    end

    def logger
      Observer::Logger
    end

    def observer
      Observer::Observer
    end
  end
end
