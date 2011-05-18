require File.expand_path('../heliosphere/server', __FILE__)
require File.expand_path('../heliosphere/config', __FILE__)

module Heliosphere

  def self.start
    server.start
  end

  def self.stop
    server.stop
  end

  def self.reindex
    server.start_and_reindex
  end

  def self.wait(&block)
    server.wait(&block)
  end

  def self.up?
    server.up?
  end

  def self.server
    @server ||= Server.new(config.port)
  end

  def self.config
    @config ||= Config.new
  end

end
