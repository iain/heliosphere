require File.expand_path('../../heliosphere', __FILE__)

module Heliosphere

  module Stubs

    extend self

    def session
      @session ||= Sunspot.session
    end

    def without_search
      Sunspot.session = Sunspot::Rails::StubSessionProxy.new(session)
    end

    def with_search
      unless Heliosphere.up?
        sunspot = Sunspot::Rails::Server.new
        pid = fork do
          STDERR.reopen('/dev/null')
          STDOUT.reopen('/dev/null')
          sunspot.run
        end
        # shut down the Solr server
        at_exit { Process.kill('TERM', pid); Heliosphere.wait(&:down?) }
        # wait for solr to start
        Heliosphere.wait(&:up?)
        sleep 1 # just to be sure
      end

      Sunspot.session = session

      wait do
        Sunspot.session.remove_all
      end
    end

    def wait(&block)
      @_waited_times ||= 0
      begin
        block.call
      rescue Errno::ECONNREFUSED
        if @_waited_times < 20
          puts "Solr not responding... keep trying "
          @_waited_times += 1
          sleep 1
          wait(&block)
        else
          puts "Giving up!"
        end
      end
    end

  end


end
