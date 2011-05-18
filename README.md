# Heliosphere

The problem with Sunspot is that it doesn't check if Solr is really running. This means that you get
a nasty connection refused error whenever you save or destroy a record. We don't want that, the
search engine is usually less important than the feature that saves models.

Heliosphere tries to solve that, by making the commit hooks a bit safer. It will index if Solr is
available, but send a request to Hoptoad if its not there. You will manually have to reindex updated
and destroyed records.

The trick Heliosphere is doing is using the Unix tool `netstat` to check if Solr is really running
and excepting requests.

There are also some helpers for Rake, Cucumber and RSpec.

## Installation

The definition of the indexes go outside your model. Create a stub by running:

    rails generate heliosphere

Modify the generated initializer to get it up and running.


## Testing Solr status by hand

Although saving records won't work now, you'll want to disable search forms or show a notice to the
user. To check manually if Solr is running:

    Heliosphere.up?
    # or ...
    Heliosphere.down?

## Rake tasks

There are alternative Rake tasks for starting/stopping/reindexing safely. The rake tasks won't fire
up and forget, but wait until the server is really running. If Solr is already running, start won't
complain, if it isn't running than stop won't complain. This means that restart will always work, no
matter if solr is running or not.

## Cucumber & RSpec

Add this for Cucumber:

    Before("~@search") do
      Heliosphere::Stubs.without_search
    end

    Before("@search") do
      Heliosphere::Stubs.with_search
    end

And this for RSpec:

    RSpec.configure do |config|
      config.extend  Heliosphere::RSpec
    end

Afterwards, use `with_search` and `without_search` inside describe blocks:

    describe User do
      without_search
      it "will update records without indexing it in Solr"
    end

## Todo

* Write tests
* Add Capistrano support
* Maybe forcefully stop Solr within testsuite
* Support other ways of notifying instead of just Hoptoad

Copyright (c) 2011 Iain Hecker, released under the MIT license
