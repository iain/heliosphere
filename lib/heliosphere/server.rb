require 'heliosphere/indexer'
require 'heliosphere/deamon_check'

module Heliosphere

  class Server

    POLL_INTERVAL = 1

    attr_reader :port

    def initialize(port)
      @port = port
    end

    def start
      Sunspot::Rails::Server.new.start unless DeamonCheck.port_up?(port)
      wait { DeamonCheck.port_up?(port) }
      sleep POLL_INTERVAL
    end

    def stop
      Sunspot::Rails::Server.new.stop if DeamonCheck.port_up?(port)
      wait { !DeamonCheck.port_up?(port) }
    end

    def start_and_reindex
      start
      reindex
    end

    def reindex
      Heliosphere.indexer.models.each do |model|
        model.remove_all_from_index
        model.index
      end
    end

    def up?
      DeamonCheck.up?(port)
    end

    def down?
      not up?
    end

    def wait(&block)
      sleep POLL_INTERVAL until yield(self)
    end

  end

end
