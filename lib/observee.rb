require 'celluloid/current'
require 'hitimes'
require 'timers'
require 'hashie'

require 'observee/version'
require 'observee/logger'
require 'observee/observer'
require 'observee/config'
require 'observee/daemon'

module Observee
  class << self
    def config
      Config.config
    end

    def logger
      Observer::Logger
    end

    def observer
      Observer::Observer
    end
  end
end
