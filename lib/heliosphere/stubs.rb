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
      end

      Sunspot.session = session
      Sunspot.session.remove_all
    end

  end


end
