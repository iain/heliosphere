require 'yaml'

module Heliosphere

  class Config

    DEFAULT_CONFIG_FILE = 'config/sunspot.yml'

    attr_reader :config_file

    def initialize(config_file = nil)
      @config_file = config_file || DEFAULT_CONFIG_FILE
    end

    def config
      @config ||= YAML.load(File.read(config_file))
    end

    def port
      @port ||= config[environment]['solr']['port']
    end

    def info
      "Running in #{environment} environment on port #{port}"
    end

    def environment
      Rails.env.to_s
    end

  end

end
