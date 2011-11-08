module Heliosphere

  class Railtie < Rails::Railtie

    config.after_initialize do |app|
      require 'heliosphere/observer'

      ar = app.config.active_record

      if ar.observers
        ar.observers += [ Heliosphere::Observer ]
      else
        ar.observers = [ Heliosphere::Observer ]
      end

      ActiveRecord::Base.observers = ar.observers
      ActiveRecord::Base.instantiate_observers
    end

    rake_tasks do
      load File.expand_path("../../tasks/heliosphere.rake", __FILE__)
    end

  end

end
