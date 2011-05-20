require 'heliosphere/observer'

module Heliosphere

  class Railtie < Rails::Railtie

    initializer "heliosphere.add_observer" do |app|
      ar = app.config.active_record
      if ar.observers
        ar.observers += [ Heliosphere::Observer ]
      else
        ar.observers = [ Heliosphere::Observer ]
      end
    end

    rake_tasks do
      load File.expand_path("../../tasks/heliosphere.rake", __FILE__)
    end

  end

end
