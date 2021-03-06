module Heliosphere

  class Server

    POLL_INTERVAL = 1

    attr_reader :port

    def initialize(port)
      @port = port
    end

    def start
      Sunspot::Rails::Server.new.start if down?
      wait(&:up?)
      sleep POLL_INTERVAL
    end

    def stop
      Sunspot::Rails::Server.new.stop if up?
      wait(&:down?)
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
      `netstat -an` =~ /\b#{port}\b/m
    end

    def down?
      not up?
    end

    def wait(&block)
      sleep POLL_INTERVAL until yield(self)
    end

  end

end
