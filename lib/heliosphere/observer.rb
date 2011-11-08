require 'heliosphere/indexer'

module Heliosphere

  class Observer < ActiveRecord::Observer

    observe *Heliosphere.indexer.models

    def after_save(object)
      running? { Sunspot.index(object) if object.index_on_save? }
    end

    def after_destroy(object)
      running? { Sunspot.remove(object) }
    end

    private

    def running?
      if Heliosphere.up?
        yield
      else
        notify_hoptoad if hoptoad?
      end
    end

    def notify_hoptoad
      HoptoadNotifier.notify(SolrNotRunning.new, :hostname => `hostname`)
    end

    def hoptoad?
      defined?(HoptoadNotifier)
    end

    class SolrNotRunning < Exception; end

  end

end
