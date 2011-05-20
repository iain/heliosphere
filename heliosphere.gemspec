# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "heliosphere/version"

Gem::Specification.new do |s|
  s.name        = "heliosphere"
  s.version     = Heliosphere::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Iain Hecker"]
  s.email       = ["iain@iain.nl"]
  s.homepage    = "https://github.com/iain/heliosphere"
  s.summary     = %q{Heliosphere makes Sunspot less dangerous by allowing updates to occur when Solr isn't running.}
  s.description = %q{Saving a record is usually more important than indexing it in Solr. Heliosphere will only index when Solr is running. It also includes some convenient rake tasks and a way to declare your indexes outside your model.}

  s.rubyforge_project = "heliosphere"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
