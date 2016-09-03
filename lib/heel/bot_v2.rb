module Heel
  module BotV2

    @registry = {}

    def self.registry
      @registry
    end

    def self.define(&block)
      definition_proxy = DefinitionProxy.new
      definition_proxy.instance_eval(&block)
    end

    attr_accessor :attributes

    def initialize
      @attributes = {
        :name     => "",
        :version  => "",
        :summary  => "",
        :author   => "",
        :license  => "",
        :helptext => ""
      }
    end

    def method_missing(name, *args, &block)
      if @attributes.has_key(name)
        if args.size == 0
          @attributes[name.to_sym]
        elsif args.size >= 1
          @attributes[name.to_sym] = args[0]
        end
      end
    end
  end

  class DefinitionProxy
    def factory(factory_class, &block)
      factory = Factory.new
      factory.instance_eval(&block)
      Heel::BotV2.registry[factory_class] = factory
    end
  end
end