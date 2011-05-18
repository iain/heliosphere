module Heliosphere

  def self.indexer
    @indexer ||= Indexer.new
  end

  class Indexer

    SEARCH_WITHOUT_LIFECYCLE = { :auto_index => false, :auto_remove => false }

    attr_accessor :block

    def define(&block)
      instance_eval(&block)
      apply
    end

    def model_names
      models.map { |model| model.name.underscore.to_sym }
    end

    def apply
      options = SEARCH_WITHOUT_LIFECYCLE
      model_definitions.each do |model, block|
        model.instance_eval do
          searchable(options, &block)
        end
      end
    end

    def index(model, &block)
      model_definitions[model] = block
    end

    def models
      model_definitions.keys
    end

    def model_definitions
      @model_definitions ||= {}
    end

  end

end
