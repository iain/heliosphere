# require File.expand_path('../../heliosphere', __FILE__)

namespace :solr do

  def run(command)
    puts Heliosphere.config.info
    puts "Executing #{command}"
    start = Time.now
    Heliosphere.send(command)
    elapsed = Time.now - start
    puts "Executed in %0.02f seconds" % elapsed
  end

  desc "Start Solr, but don't raise an error if it's already running"
  task :start => :environment do
    run :start
  end

  desc "Reindex Solr, starting it if needed"
  task :reindex => :environment do
    run :reindex
  end

  desc "Stop Solr, if running."
  task :stop => :environment do
    run :stop
  end

  desc "Restart Solr safely"
  task :restart => [ :stop, :start ]

end
