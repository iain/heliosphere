require File.expand_path('../stubs', __FILE__)

module Heliosphere

  module RSpec

    def without_search
      before :all do
        Stubs.without_search
      end
    end

    def with_search
      before :all do
        Stubs.with_search
      end
    end

  end

end
