require 'heliosphere/server'
require 'heliosphere/config'
require 'heliosphere/railtie' if defined?(Rails)

module Heliosphere

  def self.start
    server.start
  end

  def self.stop
    server.stop
  end

  def self.reindex
    server.reindex
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
