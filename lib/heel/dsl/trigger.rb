module Heel
  module DSL
    class Trigger < Bot
      attr_reader :block, :trigger

      def initialize(trigger, &block)
        @trigger = trigger
        @block = block
      end
    end
  end
end
