module Heel
  module DSL
    class Bot
      attr_reader :implementation, :triggers

      def initialize(&block)
        @triggers = Hash.new
        @implementation = nil
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

      def implement(&block)
        if @implementation == nil
          @implementation = Heel::DSL::Implement.new(&block) 
        else
          puts "[WARN] function:implement is a singleton"
        end
      end

      def trigger(msg, &block)
        @triggers[msg] = Heel::DSL::Trigger.new(msg, &block)
      end
    end

  end
end
