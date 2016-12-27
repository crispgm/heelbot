module Heel
  module BotV2
    class DSL
      def initialize(&block)
        instance_eval(&block)
      end

      def define_attr(*names)
        names.each do |name|
          define_singleton_method(name) do |val = nil|
            instance_variable_set("@#{name}", val) if val
            instance_variable_get("@#{name}")
          end
        end
      end

      def implement
      end

      def trigger
      end
    end

  end
end